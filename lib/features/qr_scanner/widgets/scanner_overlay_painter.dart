import 'package:flutter/material.dart';

class ScannerOverlayPainter extends CustomPainter {
  final double scanAreaSize;

  ScannerOverlayPainter({required this.scanAreaSize});

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
  bool shouldRepaint(ScannerOverlayPainter oldDelegate) => false;
}
