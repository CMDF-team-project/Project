import 'package:flutter/material.dart';

class CloudPainter extends CustomPainter {
  final double cloudWidth;
  final double cloudHeight;
  final double offsetX;
  final double offsetY;
  final double transparency = 0.8;

  CloudPainter(this.cloudWidth, this.cloudHeight, this.offsetX, this.offsetY);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white.withOpacity(transparency);
    paint.style = PaintingStyle.fill;

    final cloudPath = Path();

    cloudPath.addOval(Rect.fromCircle(center: Offset(offsetX, offsetY), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(offsetX + cloudWidth / 4, offsetY - cloudHeight / 3), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(offsetX + cloudWidth / 2, offsetY), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(offsetX + cloudWidth * 3 / 4, offsetY - cloudHeight / 3), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(offsetX + cloudWidth, offsetY), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(offsetX + cloudWidth / 2, offsetY + cloudHeight / 3), radius: cloudHeight / 2));
    
    cloudPath.addOval(Rect.fromCircle(center: Offset(size.width - offsetX, size.height - offsetY), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(size.width - offsetX - cloudWidth / 4, size.height - offsetY - cloudHeight / 3), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(size.width - offsetX - cloudWidth / 2, size.height - offsetY), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(size.width - offsetX - cloudWidth * 3 / 4, size.height - offsetY - cloudHeight / 3), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(size.width - offsetX - cloudWidth, size.height - offsetY), radius: cloudHeight / 2));
    cloudPath.addOval(Rect.fromCircle(center: Offset(size.width - offsetX - cloudWidth / 2, size.height - offsetY + cloudHeight / 3), radius: cloudHeight / 2));

    canvas.drawPath(cloudPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}