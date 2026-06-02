import 'dart:math' as math;

import 'package:abs/features/qr_scanner/cubit/scanner_cubit.dart';
import 'package:abs/features/qr_scanner/cubit/scanner_state.dart';
import 'package:abs/features/qr_scanner/widgets/loading_overlay.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  late final MobileScannerController _cameraController;
  late final ScannerCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cameraController = MobileScannerController();
    _cubit = ScannerCubit();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _onBarcodeDetected(BarcodeCapture capture) async {
    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null || code.isEmpty) return;

    // Stop camera immediately so the UI feels instant.
    await _cameraController.stop();
    await _cubit.onCodeDetected(code);
  }

  void _goBack() {
    _cameraController.stop();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<ScannerCubit, ScannerState>(
        listener: _handleStateChange,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Camera preview
              _buildCamera(),

              // Dark overlay with cutout effect
              Positioned.fill(
                child: CustomPaint(
                  painter: _ScannerOverlayPainter(
                    scanAreaSize: MediaQuery.of(context).size.width * 0.72,
                  ),
                ),
              ),

              // Corner brackets on the scan frame
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.72,
                  height: MediaQuery.of(context).size.width * 0.72,
                  child: Stack(
                    children: [
                      // Top-left
                      Positioned(top: 0, left: 0, child: _Corner()),
                      // Top-right
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Transform.rotate(
                          angle: math.pi / 2,
                          child: _Corner(),
                        ),
                      ),
                      // Bottom-left
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: _Corner(),
                        ),
                      ),
                      // Bottom-right
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Transform.rotate(
                          angle: math.pi,
                          child: _Corner(),
                        ),
                      ),
                      // Scan line
                      BlocBuilder<ScannerCubit, ScannerState>(
                        builder: (context, state) {
                          if (state is! ScannerLoading)
                            return const _ScanLine();
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Back button
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: IconButton(
                  onPressed: _goBack,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),

              // Title & subtitle
              Positioned(
                top: MediaQuery.of(context).padding.top + 60,
                left: 24,
                right: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.scanQrCode,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.scanQrCodeSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Loading overlay
              BlocBuilder<ScannerCubit, ScannerState>(
                builder: (context, state) {
                  if (state is ScannerLoading) return const LoadingOverlay();
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── State listener ──────────────────────────────────────────────────────────

  void _handleStateChange(BuildContext context, ScannerState state) {
    if (!mounted) return;

    if (state is ScannerSuccessScreen) {
      Navigator.pushReplacement(
        context,
        smoothRoute(page: ScannerSuccessScreen()),
      );
    } else if (state is ScannerErrorScreen) {
      Navigator.pushReplacement(
        context,
        smoothRoute(page: ScannerErrorScreen(errorMessage: 'state.message')),
      );
    }
  }

  Widget _buildCamera() {
    return MobileScanner(
      controller: _cameraController,
      onDetect: _onBarcodeDetected,
    );
  }
}

PageRouteBuilder<T> smoothRoute<T>({required Widget page}) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.06),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class ScannerSuccessScreen extends StatelessWidget {
  const ScannerSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Success'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerErrorScreen extends StatelessWidget {
  const ScannerErrorScreen({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Error'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Animated scan line
class _ScanLine extends StatefulWidget {
  const _ScanLine();

  @override
  State<_ScanLine> createState() => _ScanLineState();
}

class _ScanLineState extends State<_ScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top:
              _animation.value * (MediaQuery.of(context).size.width * 0.72 - 2),
          left: 0,
          right: 0,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.blue.shade400,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Corner bracket widget
class _Corner extends StatelessWidget {
  const _Corner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: CustomPaint(painter: _CornerPainter()),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter oldDelegate) => false;
}

// Dark overlay with transparent cutout
class _ScannerOverlayPainter extends CustomPainter {
  final double scanAreaSize;

  _ScannerOverlayPainter({required this.scanAreaSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.6);

    final center = Offset(size.width / 2, size.height / 2);
    final half = scanAreaSize / 2;
    final scanRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        center.dx - half,
        center.dy - half,
        scanAreaSize,
        scanAreaSize,
      ),
      const Radius.circular(20),
    );

    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutoutPath = Path()..addRRect(scanRect);
    final overlayPath = Path.combine(
      PathOperation.difference,
      fullPath,
      cutoutPath,
    );

    canvas.drawPath(overlayPath, paint);
  }

  @override
  bool shouldRepaint(_ScannerOverlayPainter oldDelegate) => false;
}
