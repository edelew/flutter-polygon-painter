import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polygon_painter/providers/coordonates_provider/coordonates_provider.dart';
import 'package:polygon_painter/service/line_service.dart';

class PainterPage extends ConsumerWidget {
  const PainterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineService = LineService();

    final coordinates = ref.watch(coordinatesProvider);

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
                  onTapDown: (details) {
                    ref.read(coordinatesProvider.notifier).addCoordinate(
                          details.globalPosition,
                        );
                    // if (coordinates.isEmpty) {
                    //   ref.read(coordinatesProvider.notifier).addCoordinate(
                    //         details.globalPosition,
                    //       );
                    // }
                    // else {
                    //   final List<LineEntity> lines = [];
                    //   for (var i = 0; i < coordinates.length; i++) {
                    //     if (i != 0) {
                    //       lines.add(LineEntity(
                    //         point1: coordinates[i - 1],
                    //         point2: coordinates[i],
                    //       ));
                    //     }
                    //   }

                    //   final currentLine = LineEntity(
                    //     point1: coordinates.last,
                    //     point2: details.globalPosition,
                    //   );

                    //   final isOverlap = lineService.checkLinesOverlap(
                    //     currentLine: currentLine,
                    //     lines: lines,
                    //   );

                    //   if (isOverlap == false) {
                    //     setState(() {
                    //       print(details.globalPosition);
                    //       coordinates.add(details.globalPosition);
                    //     });
                    //   }
                    // }
                  },
                  child: CustomPaint(
                    painter: PolygonPainter(
                      coordinates: coordinates,
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
    required this.coordinates,
  });

  final List<Offset> coordinates;
  @override
  void paint(Canvas canvas, Size size) async {
    final paint1 = Paint()..color = const Color.fromRGBO(253, 253, 253, 1);
    final paint2 = Paint()..color = const Color.fromRGBO(0, 152, 238, 1);
    final paint3 = Paint()
      ..color = const Color.fromRGBO(0, 0, 0, 1)
      ..strokeWidth = 8;

    // рисуем линии
    for (int i = 0; i < coordinates.length; i++) {
      if (i != 0) {
        canvas.drawLine(coordinates[i - 1], coordinates[i], paint3);
      }
    }

    // рисуем кружочки
    for (var coordinate in coordinates) {
      canvas
        ..drawCircle(coordinate, 8, paint1)
        ..drawCircle(coordinate, 6, paint2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
