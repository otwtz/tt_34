import '../../Models/weight_model.dart';

class EntryState {
  final double goalEntries;
  final List<CurEntry> curEntries;
  final double startEntries;

  EntryState({
    this.goalEntries = 0.0,
    this.curEntries = const [],
    this.startEntries = 0.0,
  });
}