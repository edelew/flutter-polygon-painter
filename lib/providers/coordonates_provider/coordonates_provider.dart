import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coordonates_provider.g.dart';

@riverpod
class Coordinates extends _$Coordinates {
  @override
  List<Offset> build() {
    return [];
  }

  void addCoordinate(Offset offset) {
    state = [...state, offset];
  }
}
