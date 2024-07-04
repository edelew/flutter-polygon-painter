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
    print('Расстояние между точками: ${distance}');

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

    print('Угол между прямыми: ${angleDeg} градусов');

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
    // Координаты точек текущей прямой
    double x1 = currentLine.point1.dx;
    double y1 = currentLine.point1.dy;
    double x2 = currentLine.point2.dx;
    double y2 = currentLine.point2.dy;

    lines.removeLast();

    for (var line in lines) {
      // Координаты точек второй прямой
      // double x3 = line.point1.dx;
      // double y3 = line.point1.dy;
      // double x4 = line.point2.dx;
      // double y4 = line.point2.dy;

      double x3 = line.point1.dx + 12;
      double y3 = line.point1.dy + 12;
      double x4 = line.point2.dx + 12;
      double y4 = line.point2.dy + 12;

      double x5 = line.point1.dx - 12;
      double y5 = line.point1.dy - 12;
      double x6 = line.point2.dx - 12;
      double y6 = line.point2.dy - 12;

      // Найдем параметры t и u
      double denominator1 = (x2 - x1) * (y4 - y3) - (y2 - y1) * (x4 - x3);

      // Проверка на параллельность прямых
      if (denominator1 == 0) {
        print('Прямые параллельны или совпадают, точки пересечения нет.');
        continue;
      }

      double t1 =
          ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denominator1;
      double u1 =
          -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denominator1;

      // Проверка, находится ли точка пересечения в пределах отрезков и не является общей точкой
      bool isCommonPoint11 = (x1 == x3 && y1 == y3) || (x1 == x4 && y1 == y4);
      bool isCommonPoint21 = (x2 == x3 && y2 == y3) || (x2 == x4 && y2 == y4);

      if (t1 >= 0 && t1 <= 1 && u1 >= 0 && u1 <= 1) {
        double intersectX = x1 + t1 * (x2 - x1);
        double intersectY = y1 + t1 * (y2 - y1);

        // Проверка, что точка пересечения не является общей точкой
        if (!((isCommonPoint11 && (intersectX == x1 && intersectY == y1)) ||
            (isCommonPoint21 && (intersectX == x2 && intersectY == y2)))) {
          print('Точка пересечения отрезков: (${intersectX}, ${intersectY})');

          // result = true;
          return true;
        }
      }

      //====================================================================================

      // Найдем параметры t и u
      double denominator2 = (x2 - x1) * (y6 - y5) - (y2 - y1) * (x6 - x5);

      // Проверка на параллельность прямых
      if (denominator2 == 0) {
        print('Прямые параллельны или совпадают, точки пересечения нет.');
        continue;
      }

      double t2 =
          ((x1 - x5) * (y3 - y6) - (y1 - y5) * (x5 - x6)) / denominator2;
      double u2 =
          -((x1 - x2) * (y1 - y5) - (y1 - y2) * (x1 - x5)) / denominator2;

      // Проверка, находится ли точка пересечения в пределах отрезков и не является общей точкой
      bool isCommonPoint12 = (x1 == x5 && y1 == y5) || (x1 == x6 && y1 == y6);
      bool isCommonPoint22 = (x2 == x5 && y2 == y5) || (x2 == x6 && y2 == y6);

      if (t2 >= 0 && t2 <= 1 && u2 >= 0 && u2 <= 1) {
        double intersectX = x1 + t2 * (x2 - x1);
        double intersectY = y1 + t2 * (y2 - y1);

        // Проверка, что точка пересечения не является общей точкой
        if (!((isCommonPoint12 && (intersectX == x1 && intersectY == y1)) ||
            (isCommonPoint22 && (intersectX == x2 && intersectY == y2)))) {
          print('Точка пересечения отрезков: (${intersectX}, ${intersectY})');

          // result = true;
          // break;

          return true;
        }
      }
    }

    print('ОТРЕЗКИ НЕ ПЕРЕСЕКАЮТСЯ.');

    return false;
  }
}
