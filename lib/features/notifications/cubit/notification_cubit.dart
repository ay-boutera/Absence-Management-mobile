import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abs/core/entities/notification_item.dart';
import 'package:abs/features/notifications/repository/notification_repository.dart';

// ── States ────────────────────────────────────────────────────────────────────

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationItem> notifications;
  final int unreadCount;

  NotificationLoaded({required this.notifications, required this.unreadCount});
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}

// ── Cubit ─────────────────────────────────────────────────────────────────────

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;
  StreamSubscription? _subscription;

  NotificationCubit(this._repository) : super(NotificationInitial());

  Future<void> loadNotifications() async {
    if (isClosed) return;
    print('🔔 [Cubit] loadNotifications called');
    emit(NotificationLoading());

    // Cancel any previous subscription before creating a new one
    await _subscription?.cancel();

    try {
      final initialItems = await _repository.getNotifications(
        page: 1,
        pageSize: 50,
      );
      if (isClosed) return;

      final unreadCount = initialItems.where((i) => !i.isRead).length;
      emit(
        NotificationLoaded(
          notifications: initialItems,
          unreadCount: unreadCount,
        ),
      );

      _subscription = _repository.watchNotifications().listen(
        (incomingItems) {
          print('🔔 [Cubit] received ${incomingItems.length} items from WS');
          if (isClosed) return;

          List<NotificationItem> currentItems = state is NotificationLoaded
              ? List<NotificationItem>.from(
                  (state as NotificationLoaded).notifications,
                )
              : [];

          if (incomingItems.length == 1 && currentItems.isNotEmpty) {
            final newItem = incomingItems.first;
            final index = currentItems.indexWhere((i) => i.id == newItem.id);
            if (index >= 0) {
              currentItems[index] = newItem;
            } else {
              currentItems.insert(0, newItem);
            }
          } else if (incomingItems.length > 1 || currentItems.isEmpty) {
            currentItems = incomingItems;
          }

          final newUnreadCount = currentItems.where((i) => !i.isRead).length;
          emit(
            NotificationLoaded(
              notifications: currentItems,
              unreadCount: newUnreadCount,
            ),
          );
        },
        onError: (Object e) {
          print('🔔 [Cubit] stream error: $e');
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(NotificationError('Failed to load notifications: $e'));
    }
  }

  Future<void> loadUnreadCount() async {
    try {
      final count = await _repository.getUnreadCount();
      if (isClosed) return;
      if (state is NotificationLoaded) {
        final current = state as NotificationLoaded;
        emit(
          NotificationLoaded(
            notifications: current.notifications,
            unreadCount: count,
          ),
        );
      }
    } catch (_) {}
  }

  Future<void> markAllAsRead() async {
    if (state is! NotificationLoaded) return;
    try {
      final current = state as NotificationLoaded;
      final updatedItems = current.notifications.map((n) {
        return NotificationItem(
          id: n.id,
          type: n.type,
          title: n.title,
          body: n.body,
          justificationId: n.justificationId,
          moduleName: n.moduleName,
          isRead: true,
          createdAt: n.createdAt,
        );
      }).toList();

      // Optimistic update first so the UI feels instant
      if (!isClosed) {
        emit(NotificationLoaded(notifications: updatedItems, unreadCount: 0));
      }

      await _repository.markAllAsRead();
    } catch (_) {
      // Silently ignore — optimistic state stays; next WS push will reconcile
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    _subscription = null;
    // dispose() closes the StreamController AND cancels the socket
    _repository.dispose();
    return super.close();
  }
}
