import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polygon_painter/presentation/polygon_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PainterPage(),
    ),
  );
}
