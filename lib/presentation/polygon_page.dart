import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polygon_painter/config/app_colors.dart';
import 'package:polygon_painter/presentation/painters/background_painters.dart';
import 'package:polygon_painter/presentation/painters/polygon_painter.dart';
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
        appBar: AppBar(
          backgroundColor: AppColors.white,
          toolbarHeight: 0,
        ),
        backgroundColor: AppColors.lightGrey,
        body: CustomPaint(
          painter: BackgroundPaint(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.constrainWidth(),
                height: constraints.constrainHeight(),
                child: GestureDetector(
                  // первое нажатие
                  onPanStart: (details) {
                    if (polygon.isFinished) return;

                    final currentCoordinate = details.globalPosition;

                    ref.read(polygonProvider.notifier).addCoordinate(
                          currentCoordinate,
                        );
                  },
                  // удержание
                  onPanUpdate: (details) {
                    if (polygon.isFinished) return;

                    final currentCoordinate = details.globalPosition;

                    ref.read(polygonProvider.notifier).updateLastCoordinate(
                          currentCoordinate,
                        );
                  },
                  // после нажатия
                  onPanEnd: (details) {
                    if (polygon.isFinished) return;

                    final currentCoordinate = polygon.coordinates.last;
                    final coordinates = ref
                        .read(polygonProvider.notifier)
                        .getCoordinatesExceptLast();

                    final lines = ref.read(polygonProvider.notifier).getLines(
                          isExceptLast: true,
                        );

                    if (lines.isNotEmpty) {
                      final currentLine =
                          ref.read(polygonProvider.notifier).getLines().last;

                      final isEnoughDegrees = lineService.checkAngle(
                        firstLine: currentLine,
                        secondLine: lines.last,
                      );

                      final isOverlap = lineService.checkLinesOverlap(
                        currentLine: currentLine,
                        lines: lines,
                      );

                      final isClose = lineService.isNearFirstPoint(
                        firstPoint: coordinates.first,
                        currentPoint: currentCoordinate,
                      );

                      if (isClose) {
                        lines.removeAt(0);
                        final isOverlap = lineService.checkLinesOverlap(
                          currentLine: currentLine,
                          lines: lines,
                        );
                        if (!isOverlap) {
                          ref
                              .read(polygonProvider.notifier)
                              .updateLastCoordinate(
                                coordinates.first,
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
