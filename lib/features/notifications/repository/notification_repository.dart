import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:abs/core/network/api_services.dart';
import 'package:abs/core/network/api_endpoints.dart';
import 'package:abs/core/entities/notification_item.dart';

class NotificationRepository {
  final ApiServices _apiServices;
  final FlutterSecureStorage _secureStorage;

  WebSocketChannel? _channel;
  StreamSubscription? _channelSubscription;

  // Use a single broadcast controller that lives for the repo's lifetime
  final _controller = StreamController<List<NotificationItem>>.broadcast();

  bool _isConnected = false;
  bool _isDisposed = false;

  // Reconnect back-off: 2s → 4s → 8s … up to 30s
  static const _maxReconnectDelay = Duration(seconds: 30);
  Duration _reconnectDelay = const Duration(seconds: 2);
  Timer? _reconnectTimer;

  NotificationRepository(this._apiServices, this._secureStorage);

  // ── Public API ──────────────────────────────────────────────────────────────

  Stream<List<NotificationItem>> watchNotifications() {
    // Kick off connection (fire-and-forget, errors handled internally)
    _connectSafely();
    return _controller.stream;
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _isConnected = false;
    _channelSubscription?.cancel();
    _channelSubscription = null;
    _channel?.sink.close();
    _channel = null;
  }

  void dispose() {
    _isDisposed = true;
    disconnect();
    _controller.close();
  }

  Future<List<NotificationItem>> getNotifications({int page = 1, int pageSize = 20}) async {
    try {
      final response = await _apiServices.get(
        ApiEndpoints.notifications,
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null && response.data['data'] != null) {
        final List data = response.data['data'];
        return data.map((json) => NotificationItem.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _apiServices.get(
        ApiEndpoints.notificationsUnreadCount,
      );
      return (response.data['count'] as int?) ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<void> markAsRead(String id) async {
    await _apiServices.patch('${ApiEndpoints.notifications}/$id/read');
  }

  Future<void> markAllAsRead() async {
    await _apiServices.post(ApiEndpoints.notificationsReadAll);
  }

  // ── Connection helpers ───────────────────────────────────────────────────────

  void _connectSafely() {
    if (_isDisposed || _isConnected) return;
    _connect().catchError((e) {
      _scheduleReconnect();
    });
  }

  Future<void> _connect() async {
    print(
      '🔌 [Repo] _connect called, isDisposed=$_isDisposed, isConnected=$_isConnected',
    );
    if (_isDisposed || _isConnected) return;

    // Read tokens before touching the socket
    final accessToken = await _secureStorage.read(key: 'access_token');

    final baseUrl = _apiServices.baseUrl
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
        
    final wsUrl = '$baseUrl/api/v1/ws${ApiEndpoints.notifications}?token=${accessToken ?? ''}';
    final uri = Uri.parse(wsUrl);

    // WebSocketChannel.connect() itself won't throw — errors surface on .stream.
    // Mark connected *after* we've started listening so that onError can flip it.
    _channel = WebSocketChannel.connect(uri);

    // Wait for the ready future (added in web_socket_channel 2.x).
    // This is where connection-level errors (bad URL, refused, etc.) throw.
    try {
      await _channel!.ready;
      print('🔌 [Repo] WebSocket connected successfully to $wsUrl');
    } catch (e) {
      print('🔌 [Repo] WebSocket connection FAILED: $e');
      _channel = null;
      rethrow;
    }

    _isConnected = true;
    _reconnectDelay = const Duration(seconds: 2); // reset back-off on success

    _channelSubscription = _channel!.stream.listen(
      _handleMessage,
      onError: (error) {
        _isConnected = false;
        // Forward to cubit only if the stream has listeners and the controller
        // is still open, so the cubit can show an empty-state gracefully.
        if (!_controller.isClosed) _controller.addError(error);
        _scheduleReconnect();
      },
      onDone: () {
        _isConnected = false;
        _scheduleReconnect();
      },
      cancelOnError: false,
    );
  }

  void _handleMessage(dynamic message) {
    if (_controller.isClosed) return;
    try {
      final decoded = jsonDecode(message as String);
      final List<NotificationItem> items;

      if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
        items = (decoded['data'] as List)
            .map((j) => NotificationItem.fromJson(j as Map<String, dynamic>))
            .toList();
      } else if (decoded is List) {
        items = decoded
            .map((j) => NotificationItem.fromJson(j as Map<String, dynamic>))
            .toList();
      } else if (decoded is Map<String, dynamic>) {
        items = [NotificationItem.fromJson(decoded)];
      } else {
        return; // ignore unexpected shapes
      }

      _controller.add(items);
    } catch (_) {
      // Malformed message — skip silently, don't crash
    }
  }

  void _scheduleReconnect() {
    if (_isDisposed || _reconnectTimer != null) return;

    _reconnectTimer = Timer(_reconnectDelay, () {
      _reconnectTimer = null;
      _connectSafely();
    });

    // Exponential back-off, capped at _maxReconnectDelay
    _reconnectDelay = Duration(
      seconds: (_reconnectDelay.inSeconds * 2).clamp(
        2,
        _maxReconnectDelay.inSeconds,
      ),
    );
  }
}
