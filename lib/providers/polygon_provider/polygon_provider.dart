import 'package:flutter/material.dart';
import 'package:polygon_painter/entity/line_entity.dart';
import 'package:polygon_painter/entity/polygon_entity/polygon_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'polygon_provider.g.dart';

@riverpod
class Polygon extends _$Polygon {
  @override
  PolygonEntity build() {
    return PolygonEntity(coordinates: []);
  }

  void addCoordinate(Offset offset) {
    final coordinates = [...state.coordinates, offset];

    if (coordinates.length > 2 && coordinates.last == coordinates.first) {
      state = PolygonEntity(
        coordinates: coordinates,
        isFinished: true,
      );
    } else {
      state = state.copyWith(
        coordinates: coordinates,
      );
    }
  }

  List<LineEntity> getLines() {
    final coordinates = state.coordinates;

    if (coordinates.isNotEmpty) {
      final List<LineEntity> lines = [];
      for (var i = 0; i < coordinates.length; i++) {
        if (i != 0) {
          lines.add(LineEntity(
            point1: coordinates[i - 1],
            point2: coordinates[i],
          ));
        }
      }

      return lines;
    } else {
      return [];
    }
  }
}
