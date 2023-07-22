import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPainterNumbersOnArc extends CustomPainter {
  final int count;

  CustomPainterNumbersOnArc({
    required this.count,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final anglePerNumber = 2 * math.pi / 10;
    for (int i = 0; i <= 10; i++) {
      String? numText;
      double? numAngle;
      if (i <= count) {
        for (int j = 0; j <= count; j++) {
          numText = (i * 100).toString();
          numAngle = i * anglePerNumber - math.pi;
        }
      } else {
        numText = "";
        numAngle = 0;
      }

      final double x = 10 + 120 * math.cos(numAngle!);
      final double y = 10 + 120 * math.sin(numAngle);

      final TextSpan textSpan = TextSpan(
        text: numText,
        style: const TextStyle(color: Colors.black),
      );

      final TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final Offset numOffset =
          Offset(x - textPainter.width, y - textPainter.height);

      textPainter.paint(canvas, numOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
