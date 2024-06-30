import 'package:flutter/material.dart';

class MoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final moonCenter = Offset(size.width / 2, size.height / 2);
    final moonRadius = size.width / 3;
    canvas.drawCircle(moonCenter, moonRadius, paint);

    final craterPaint = Paint()
      ..color = const Color.fromARGB(200, 158, 158, 158)
      ..style = PaintingStyle.fill;

    final craters = [
      Offset(moonCenter.dx + 30, moonCenter.dy - 20),
      Offset(moonCenter.dx - 40, moonCenter.dy + 10),
      Offset(moonCenter.dx, moonCenter.dy + 40),
    ];

    final craterRadii = [10.0, 15.0, 8.0];

    for (int i = 0; i < craters.length; i++) {
      canvas.drawCircle(craters[i], craterRadii[i], craterPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: MoonPainter(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Moon with Craters')),
      body: Center(
        child: MoonWidget(),
      ),
    ),
  ));
}
