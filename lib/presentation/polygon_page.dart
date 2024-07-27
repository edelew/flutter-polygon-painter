import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polygon_painter/config/app_colors.dart';
import 'package:polygon_painter/presentation/painters/background_painters.dart';
import 'package:polygon_painter/presentation/painters/polygon_painter.dart';
import 'package:polygon_painter/presentation/widgets/control_panel.dart';
import 'package:polygon_painter/providers/polygon_provider/polygon_provider.dart';
import 'package:polygon_painter/service/line_service.dart';

class PainterPage extends ConsumerStatefulWidget {
  const PainterPage({super.key});

  @override
  ConsumerState<PainterPage> createState() => _PainterPageState();
}

class _PainterPageState extends ConsumerState<PainterPage> {
  @override
  Widget build(BuildContext context) {
    final lineService = LineService();

    final polygon = ref.watch(polygonProvider);
    final polygonNotifier = ref.read(polygonProvider.notifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          toolbarHeight: 0,
        ),
        backgroundColor: AppColors.grey,
        body: CustomPaint(
          painter: BackgroundPaint(),
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.constrainWidth(),
                    height: constraints.constrainHeight(),
                    child: GestureDetector(
                      // первое нажатие
                      onPanStart: (details) {
                        if (polygon.isFinished) return;

                        final currentCoordinate = details.localPosition;

                        polygonNotifier.addCoordinate(
                          currentCoordinate,
                        );
                      },
                      // удержание
                      onPanUpdate: (details) {
                        if (polygon.isFinished) return;

                        final currentCoordinate = details.localPosition;

                        polygonNotifier.updateLastCoordinate(
                          currentCoordinate,
                        );
                      },
                      // после нажатия
                      onPanEnd: (details) {
                        if (polygon.isFinished) return;

                        final currentCoordinate = polygon.coordinates.last;
                        final coordinates =
                            polygonNotifier.getCoordinatesExceptLast();

                        final lines = polygonNotifier.getLines(
                          isExceptLast: true,
                        );

                        if (lines.isNotEmpty) {
                          final currentLine = polygonNotifier.getLines().last;

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
                              polygonNotifier.updateLastCoordinate(
                                coordinates.first,
                              );

                              return;
                            } else {
                              polygonNotifier.removeLastCoordinate();

                              return;
                            }
                          } else if (!isEnoughDegrees || isOverlap) {
                            polygonNotifier.removeLastCoordinate();

                            return;
                          }
                        }

                        polygonNotifier.addToHistory(polygon);
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 8,
                  right: 16,
                ),
                child: ControlPanelWidget(
                  polygonNotifier: polygonNotifier,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
