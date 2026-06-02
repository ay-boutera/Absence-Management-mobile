import 'dart:math' as math;

import 'package:abs/features/qr_scanner/cubit/scanner_cubit.dart';
import 'package:abs/features/qr_scanner/cubit/scanner_state.dart';
import 'package:abs/features/qr_scanner/helpers/page_route_builder.dart';
import 'package:abs/features/qr_scanner/screens/scanner_error_screen.dart';
import 'package:abs/features/qr_scanner/screens/scanner_success_screen.dart';
import 'package:abs/features/qr_scanner/widgets/corner.dart';
import 'package:abs/features/qr_scanner/widgets/loading_overlay.dart';
import 'package:abs/features/qr_scanner/widgets/scan_line.dart';
import 'package:abs/features/qr_scanner/widgets/scanner_overlay_painter.dart';
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
                  painter: ScannerOverlayPainter(
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
                      Positioned(top: 0, left: 0, child: Corner()),
                      // Top-right
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Transform.rotate(
                          angle: math.pi / 2,
                          child: Corner(),
                        ),
                      ),
                      // Bottom-left
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Corner(),
                        ),
                      ),
                      // Bottom-right
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Transform.rotate(
                          angle: math.pi,
                          child: Corner(),
                        ),
                      ),
                      // Scan line
                      BlocBuilder<ScannerCubit, ScannerState>(
                        builder: (context, state) {
                          if (state is! ScannerLoading) return const ScanLine();
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

  void _handleStateChange(BuildContext context, ScannerState state) {
    if (!mounted) return;

    // Check against the State types, not the Screen widgets
    if (state is ScannerSuccess) {
      Navigator.pushReplacement(
        context,
        smoothRoute(page: ScannerSuccessScreen()),
      );
    } else if (state is ScannerError) {
      Navigator.pushReplacement(
        context,
        smoothRoute(page: ScannerErrorScreen(errorMessage: state.message)),
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
