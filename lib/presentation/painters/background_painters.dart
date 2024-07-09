import 'package:flutter/material.dart';

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final heightStep = height / 30;
    final width = size.width;
    final widthStep = width / 14;

    final paint = Paint()..color = Colors.blue;

    for (double i = widthStep / 2; i < width; i += widthStep) {
      for (double j = widthStep / 2; j < height; j += heightStep) {
        canvas.drawCircle(Offset(i, j), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
