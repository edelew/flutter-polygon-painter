import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polygon_painter/entity/line_entity.dart';
import 'package:polygon_painter/entity/polygon_entity/polygon_entity.dart';
import 'package:polygon_painter/providers/polygon_provider/polygon_provider.dart';
import 'package:polygon_painter/service/line_service.dart';

class PainterPage extends ConsumerWidget {
  const PainterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineService = LineService();

    final polygon = ref.watch(polygonProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(227, 227, 227, 1),
        body: CustomPaint(
          painter: BackgroundPaint(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.constrainWidth(),
                height: constraints.constrainHeight(),
                child: GestureDetector(
                  onPanStart: (details) {
                    final isFinished = polygon.isFinished;
                    if (isFinished) return;

                    final currentCoordinate = details.globalPosition;

                    ref.read(polygonProvider.notifier).addCoordinate(
                          currentCoordinate,
                        );
                  },
                  onPanUpdate: (details) {
                    final isFinished = polygon.isFinished;
                    if (isFinished) return;

                    final currentCoordinate = details.globalPosition;

                    ref.read(polygonProvider.notifier).updateLastCoordinate(
                          currentCoordinate,
                        );
                  },
                  onPanEnd: (details) {
                    final isFinished = polygon.isFinished;
                    if (isFinished) return;

                    final currentCoordinate = polygon.coordinates.last;
                    final otherCoordinates = polygon.coordinates.sublist(
                      0,
                      polygon.coordinates.length - 1,
                    );
                    final allLines =
                        ref.read(polygonProvider.notifier).getLines();
                    final otherLines = allLines.sublist(
                      0,
                      allLines.length - 1,
                    );

                    if (otherLines.isNotEmpty) {
                      final currentLine = LineEntity(
                        point1: otherCoordinates.last,
                        point2: currentCoordinate,
                      );

                      final isEnoughDegrees = lineService.checkAngle(
                        firstLine: currentLine,
                        secondLine: otherLines.last,
                      );

                      final isOverlap = lineService.checkLinesOverlap(
                        currentLine: currentLine,
                        lines: otherLines,
                      );

                      final isClose = lineService.isNearFirstPoint(
                        firstPoint: otherCoordinates.first,
                        currentPoint: currentCoordinate,
                      );

                      if (isClose) {
                        otherLines.removeAt(0);
                        final isOverlap = lineService.checkLinesOverlap(
                          currentLine: currentLine,
                          lines: otherLines,
                        );
                        if (!isOverlap) {
                          ref
                              .read(polygonProvider.notifier)
                              .updateLastCoordinate(
                                otherCoordinates.first,
                              );
                        } else {
                          ref
                              .read(polygonProvider.notifier)
                              .removeLastCoordinate();
                        }
                      } else if (!isEnoughDegrees || isOverlap) {
                        ref
                            .read(polygonProvider.notifier)
                            .removeLastCoordinate();
                      }
                    }
                  },
                  child: CustomPaint(
                    painter: PolygonPainter(
                      polygon: polygon,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

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
        ..color = const Color.fromRGBO(253, 253, 253, 1);

      final path = Path()..moveTo(coordinates.first.dx, coordinates.first.dy);
      for (int i = 1; i < coordinates.length; i++) {
        path.lineTo(coordinates[i].dx, coordinates[i].dy);
      }
      canvas.drawPath(path, backgroundPaint);
    }

    // рисуем линии
    final linePaint = Paint()
      ..color = const Color.fromRGBO(0, 0, 0, 1)
      ..strokeWidth = 8;
    for (int i = 0; i < coordinates.length; i++) {
      if (i != 0) {
        canvas.drawLine(coordinates[i - 1], coordinates[i], linePaint);
      }
    }

    // рисуем кружочки
    final circlePaint1 = Paint()
      ..color = isFinished
          ? const Color.fromRGBO(125, 125, 125, 1)
          : const Color.fromRGBO(253, 253, 253, 1);
    final circlePaint2 = Paint()
      ..color = isFinished
          ? const Color.fromRGBO(253, 253, 253, 1)
          : const Color.fromRGBO(0, 152, 238, 1);

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
