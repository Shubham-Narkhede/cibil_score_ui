import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPainterBackground extends CustomPainter {
  CustomPainterBackground();

  @override
  bool shouldRepaint(CustomPainterBackground oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    Path path = Path()..arcTo(rect, math.pi / 3, -math.pi, true);
    canvas.drawPath(
        path,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade100,
              Colors.grey.shade100,
              Colors.grey.shade300,
            ],
          ).createShader(rect)
          ..style = PaintingStyle.fill);

    canvas.drawArc(
        rect,
        math.pi / 1.5,
        math.pi,
        false,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade100,
              Colors.grey.shade100,
              Colors.grey.shade300,
            ],
          ).createShader(rect)
          ..style = PaintingStyle.fill);
  }
}
