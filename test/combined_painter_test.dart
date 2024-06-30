import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:team_project/custom%20painter/combined_painter.dart';

void main() {
  testGoldens('CombinedPainter Golden Test', (tester) async {
    // Define the widget to test
    final widget = Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: CombinedPainter(
          50, // sunRadius
          1.0, // sunProgress
          0.0, // sunRotation
          20, // rayLength
          100, // cloudWidth
          50, // cloudHeight
          20, // cloudOffsetX
          20, // cloudOffsetY
        ),
      ),
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(child: widget),
        ),
      ),
    );

    // Compare against golden file
    await expectLater(
      find.byType(Container),
      matchesGoldenFile('combined_painter_golden.png'),
    );
  });
}
