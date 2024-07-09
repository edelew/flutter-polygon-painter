import 'dart:math';

import 'package:flutter/material.dart';

class LineEntity {
  LineEntity({
    required this.point1,
    required this.point2,
    required this.length,
    required this.angle,
    required this.midPoint,
  });

  final Offset point1;
  final Offset point2;
  final double length;
  final double angle;
  final Offset midPoint;

  factory LineEntity.fromCoordinates({
    required Offset coordinates1,
    required Offset coordinates2,
  }) {
    final length = _calculateLength(
      coordinates1: coordinates1,
      coordinates2: coordinates2,
    );

    final midPoint = _calculateMidPoint(
      coordinates1: coordinates1,
      coordinates2: coordinates2,
    );

    final angle = _calculateAngle(
      coordinates1: coordinates1,
      coordinates2: coordinates2,
    );

    return LineEntity(
      point1: coordinates1,
      point2: coordinates2,
      length: length,
      angle: angle,
      midPoint: midPoint,
    );
  }

  // нахождение длины отрезка
  static double _calculateLength({
    required Offset coordinates1,
    required Offset coordinates2,
  }) {
    double dx = coordinates1.dx - coordinates2.dx;
    double dy = coordinates1.dy - coordinates2.dy;

    final length = sqrt(dx * dx + dy * dy);

    return length;
  }

  // нахождение угла отрезка
  static double _calculateAngle({
    required Offset coordinates1,
    required Offset coordinates2,
  }) {
    double dy = coordinates1.dy - coordinates1.dy;
    double dx = coordinates2.dx - coordinates2.dx;

    double angleInRadians = atan2(dy, dx);
    double angleInDegrees = angleInRadians * (180 / pi);

    return angleInDegrees;
  }

  // нахождение середины отрезка
  static Offset _calculateMidPoint({
    required Offset coordinates1,
    required Offset coordinates2,
  }) {
    double midX = (coordinates1.dx + coordinates2.dx) / 2;
    double midY = (coordinates1.dy + coordinates2.dy) / 2;

    final midPoint = Offset(midX, midY);
    return midPoint;
  }
}
