import 'package:flutter/material.dart';

class CustomPainterArrowIndicator extends CustomPainter {
  Color? color;
  CustomPainterArrowIndicator({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey.shade700;

    final arrowPath = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(arrowPath, paint);
    canvas.drawCircle(
        const Offset(14, -14), 13, Paint()..color = color ?? Colors.red);

    canvas.drawCircle(const Offset(14, -14), 7, Paint()..color = Colors.white);
    canvas.drawCircle(
        const Offset(14, -14), 5, Paint()..color = color ?? Colors.red);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}