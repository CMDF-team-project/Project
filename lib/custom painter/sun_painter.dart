import 'dart:math';
import 'package:flutter/material.dart';

class SunPainter extends CustomPainter {
  final double sunRadius;
  final double progress;
  final double rotation;
  final double rayLength;
  final double raySickness;

  SunPainter(this.sunRadius, this.progress, this.rotation, this.rayLength, this.raySickness);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.fill;

    final dx = size.width / 2;
    final dy = size.height / 2;

    canvas.save();
    canvas.translate(dx, dy);
    canvas.rotate(rotation);

    canvas.drawCircle(const Offset(0, 0), sunRadius, paint);

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = raySickness;

    for (double angle = 0; angle < 2 * pi; angle += pi / 6) {
      final x1 = cos(angle) * sunRadius;
      final y1 = sin(angle) * sunRadius;
      final x2 = cos(angle) * (sunRadius + rayLength);
      final y2 = sin(angle) * (sunRadius + rayLength);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
