import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 6);
    final radius = size.width * 0.32;

    // Clock face
    final facePaint = Paint()
      ..color = const Color(0xFFE8EAF6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    final borderPaint = Paint()
      ..color = const Color(0xFF9FA8DA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, borderPaint);

    // Clock hands
    final handPaint = Paint()
      ..color = const Color(0xFF3F51B5)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Hour hand
    canvas.drawLine(center, center + Offset(0, -radius * 0.5), handPaint);
    // Minute hand
    canvas.drawLine(center, center + Offset(radius * 0.6, 0), handPaint);

    // Wings (arcs)
    final wingPaint = Paint()
      ..color = const Color(0xFFB0BEC5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawArc(
      Rect.fromCenter(
        center: center - Offset(radius + 4, 0),
        width: radius * 1.2,
        height: radius * 0.9,
      ),
      0.3,
      -2.6,
      false,
      wingPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: center + Offset(radius + 4, 0),
        width: radius * 1.2,
        height: radius * 0.9,
      ),
      2.8,
      -2.6,
      false,
      wingPaint,
    );

    // Stars (dots)
    final starPaint = Paint()..color = const Color(0xFF9FA8DA);
    canvas.drawCircle(
      center + Offset(size.width * 0.35, -size.height * 0.35),
      2,
      starPaint,
    );
    canvas.drawCircle(
      center + Offset(size.width * 0.42, -size.height * 0.2),
      1.2,
      starPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
