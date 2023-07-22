import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vmath;

class CustomPainterAnalogMeter extends CustomPainter {
  final double value, meterValue;

  CustomPainterAnalogMeter({required this.value, required this.meterValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    const Gradient gradient = SweepGradient(
      startAngle: 1.25 * math.pi / 2,
      endAngle: 5.1 * math.pi / 2,
      tileMode: TileMode.repeated,
      colors: <Color>[
        Colors.red,
        Colors.yellow,
        Colors.green,
      ],
    );

    canvas.drawArc(
      Rect.fromCenter(center: center, width: 170, height: 170),
      vmath.radians(180),
      vmath.radians((0.36 * meterValue) * value),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..shader = gradient
            .createShader(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
        ..strokeWidth = 15,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
