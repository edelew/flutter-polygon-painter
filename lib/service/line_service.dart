import 'dart:math';

import 'package:flutter/material.dart';
import 'package:polygon_painter/entity/line_entity.dart';

class LineService {
  bool isNearFirstPoint({
    required Offset firstPoint,
    required Offset currentPoint,
  }) {
    // Координаты первой точки
    double x1 = firstPoint.dx;
    double y1 = firstPoint.dy;

    // Координаты второй точки
    double x2 = currentPoint.dx;
    double y2 = currentPoint.dy;

    // Вычисление расстояния
    double distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));

    // Вывод результата
    print('Расстояние между точками: $distance');

    if (distance < 20) {
      return true;
    } else {
      return false;
    }
  }

  bool checkAngle({
    required LineEntity firstLine,
    required LineEntity secondLine,
  }) {
    // Координаты точек первой прямой
    double x1 = firstLine.point1.dx;
    double y1 = firstLine.point1.dy;
    double x2 = firstLine.point2.dx;
    double y2 = firstLine.point2.dy;

    // Координаты точек второй прямой
    double x3 = secondLine.point1.dx;
    double y3 = secondLine.point1.dy;
    double x4 = secondLine.point2.dx;
    double y4 = secondLine.point2.dy;

    // Векторы направлений
    double v1x = x2 - x1;
    double v1y = y2 - y1;
    double v2x = x4 - x3;
    double v2y = y4 - y3;

    // Скалярное произведение
    double dotProduct = v1x * v2x + v1y * v2y;

    // Длины векторов
    double lengthV1 = sqrt(v1x * v1x + v1y * v1y);
    double lengthV2 = sqrt(v2x * v2x + v2y * v2y);

    // Угол между векторами в радианах
    double angleRad = acos(dotProduct / (lengthV1 * lengthV2));

    // Угол в градусах
    double angleDeg = 180 - (angleRad * 180 / pi);

    print('Угол между прямыми: $angleDeg градусов');

    if (angleDeg > 10) {
      return true;
    } else {
      return false;
    }
  }

  bool checkLinesOverlap({
    required LineEntity currentLine,
    required List<LineEntity> lines,
  }) {
    lines.removeLast();

    for (var line in lines) {
      final isPositiveOffsetOverlap = _checkOverlapWithOffset(
        currentLine: currentLine,
        secondLine: line,
        offset: 12,
      );

      final isNegativeOffsetOverlap = _checkOverlapWithOffset(
        currentLine: currentLine,
        secondLine: line,
        offset: -12,
      );

      if (isPositiveOffsetOverlap || isNegativeOffsetOverlap) {
        return true;
      } else {
        continue;
      }
    }

    return false;
  }

  bool _checkOverlapWithOffset({
    required LineEntity currentLine,
    required LineEntity secondLine,
    required double offset,
  }) {
    // Координаты точек текущей прямой
    double x1 = currentLine.point1.dx;
    double y1 = currentLine.point1.dy;
    double x2 = currentLine.point2.dx;
    double y2 = currentLine.point2.dy;

    // Координаты точек прямой со смещением [offset]
    double x3 = secondLine.point1.dx + offset;
    double y3 = secondLine.point1.dy + offset;
    double x4 = secondLine.point2.dx + offset;
    double y4 = secondLine.point2.dy + offset;

    // Найдем параметры t и u
    double denominator = (x2 - x1) * (y4 - y3) - (y2 - y1) * (x4 - x3);

    double t1 = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denominator;
    double u1 = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denominator;

    // Проверка, находится ли точка пересечения в пределах отрезков и не является общей точкой
    bool isCommonPoint1 = (x1 == x3 && y1 == y3) || (x1 == x4 && y1 == y4);
    bool isCommonPoint2 = (x2 == x3 && y2 == y3) || (x2 == x4 && y2 == y4);

    if (t1 >= 0 && t1 <= 1 && u1 >= 0 && u1 <= 1) {
      double intersectX = x1 + t1 * (x2 - x1);
      double intersectY = y1 + t1 * (y2 - y1);

      // Проверка, что точка пересечения не является общей точкой
      if (!((isCommonPoint1 && (intersectX == x1 && intersectY == y1)) ||
          (isCommonPoint2 && (intersectX == x2 && intersectY == y2)))) {
        print('Точка пересечения отрезков: ($intersectX, $intersectY)');

        return true;
      }
    }

    print('ОТРЕЗКИ НЕ ПЕРЕСЕКАЮТСЯ.');
    return false;
  }
}
