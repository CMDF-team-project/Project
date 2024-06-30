import 'package:flutter/material.dart';
import 'package:team_project/custom%20painter/sun_painter.dart';
import 'package:team_project/custom%20painter/cloud_painter.dart';

class CombinedPainter extends CustomPainter {
  final double sunRadius;
  final double sunProgress;
  final double sunRotation;
  final double rayLength;
  final double cloudWidth;
  final double cloudHeight;
  final double cloudOffsetX;
  final double cloudOffsetY;

  CombinedPainter(
      this.sunRadius,
      this.sunProgress,
      this.sunRotation,
      this.rayLength,
      this.cloudWidth,
      this.cloudHeight,
      this.cloudOffsetX,
      this.cloudOffsetY
  );

  @override
  void paint(Canvas canvas, Size size) {
    SunPainter(sunRadius, sunProgress, sunRotation, rayLength, 4).paint(canvas, size);

    CloudPainter(cloudWidth, cloudHeight, cloudOffsetX, cloudOffsetY).paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
