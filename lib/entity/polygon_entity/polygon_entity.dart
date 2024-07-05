import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'polygon_entity.freezed.dart';

@freezed
class PolygonEntity with _$PolygonEntity {
  factory PolygonEntity({
    required List<Offset> coordinates,
    @Default(false) bool isFinished,
  }) = _PolygonEntity;
}
