import 'package:polygon_painter/entity/line_entity.dart';
import 'package:polygon_painter/providers/coordonates_provider/coordonates_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lines_provider.g.dart';

@riverpod
List<LineEntity> lines(LinesRef ref) {
  final coordinates = ref.watch(coordinatesProvider);

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
