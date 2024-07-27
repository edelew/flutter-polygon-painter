import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin HistoryMixin<T> on AutoDisposeNotifier<T> {
  List<T> _history = [];

  int _undoIndex = 0;

  bool get canUndo => _undoIndex + 1 < _history.length;

  bool get canRedo => _undoIndex > 0;

  void undo() {
    if (canUndo) {
      super.state = _history[++_undoIndex];
    }
  }

  void redo() {
    if (canRedo) {
      super.state = _history[--_undoIndex];
    }
  }

  void addToHistory(T value) {
    _clearRedoHistory();
    _history.insert(0, value);
    super.state = state;
  }

  void _clearRedoHistory() {
    _history = _history.sublist(_undoIndex, _history.length);
    _undoIndex = 0;
  }
}
