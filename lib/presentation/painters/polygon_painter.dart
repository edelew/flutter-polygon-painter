import 'package:flutter/material.dart';
import 'package:polygon_painter/config/app_colors.dart';
import 'package:polygon_painter/entity/polygon_entity/polygon_entity.dart';

class PolygonPainter extends CustomPainter {
  PolygonPainter({
    super.repaint,
    required this.polygon,
  });

  final PolygonEntity polygon;

  @override
  void paint(Canvas canvas, Size size) async {
    final List<Offset> coordinates = polygon.coordinates;
    final isFinished = polygon.isFinished;

    // рисуем фон когда многоугльник закончен
    if (isFinished) {
      final backgroundPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = AppColors.white;

      final path = Path()..moveTo(coordinates.first.dx, coordinates.first.dy);
      for (int i = 1; i < coordinates.length; i++) {
        path.lineTo(coordinates[i].dx, coordinates[i].dy);
      }
      canvas.drawPath(path, backgroundPaint);
    }

    // рисуем линии
    final linePaint = Paint()
      ..color = AppColors.black
      ..strokeWidth = 8;
    for (int i = 0; i < coordinates.length; i++) {
      if (i != 0) {
        canvas.drawLine(coordinates[i - 1], coordinates[i], linePaint);
      }
    }

    // рисуем кружочки
    final circlePaint1 = Paint()
      ..color = isFinished ? AppColors.darkGrey : AppColors.white;
    final circlePaint2 = Paint()
      ..color = isFinished ? AppColors.white : AppColors.blue;

    for (var coordinate in coordinates) {
      canvas
        ..drawCircle(coordinate, 8, circlePaint1)
        ..drawCircle(coordinate, 6, circlePaint2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
