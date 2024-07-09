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

  void removeLastCoordinate() {
    final coordinates = state.coordinates;
    if (coordinates.isNotEmpty) {
      state = state.copyWith(
        coordinates: coordinates.sublist(0, coordinates.length - 1),
      );
    }
  }

  void updateLastCoordinate(Offset newValue) {
    final coordinates = state.coordinates;
    if (coordinates.isNotEmpty) {
      List<Offset> updatedCoordinates = List.from(coordinates);

      updatedCoordinates[updatedCoordinates.length - 1] = newValue;

      if (updatedCoordinates.length > 2 &&
          updatedCoordinates.last == updatedCoordinates.first) {
        state = PolygonEntity(
          coordinates: updatedCoordinates,
          isFinished: true,
        );
      } else {
        state = state.copyWith(
          coordinates: updatedCoordinates,
        );
      }
    }
  }

  List<LineEntity> getLines({isExceptLast = false}) {
    final coordinates = state.coordinates;

    final length = isExceptLast ? coordinates.length - 1 : coordinates.length;

    if (coordinates.isNotEmpty) {
      final List<LineEntity> lines = [];
      for (var i = 0; i < length; i++) {
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

  List<Offset> getCoordinatesExceptLast() {
    final coordinates = state.coordinates;

    List<Offset> coordinatesExceptLast =
        coordinates.sublist(0, coordinates.length - 1);

    return coordinatesExceptLast;
  }
}
