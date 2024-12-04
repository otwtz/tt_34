import '../../Models/entry_model.dart';

class RecordState {
  final List<Entry> records;
  final bool isLoading;
  final List<Entry> currentEntryByDate;
  final DateTime? currentDateTime;

  RecordState({
    required this.records,
    this.isLoading = false,
    required this.currentEntryByDate,
    this.currentDateTime,
  });

  factory RecordState.initial() {
    return RecordState(
      records: [],
      isLoading: false,
      currentEntryByDate: [],
    );
  }

  RecordState copyWith({
    DateTime? currentDateTime,
    List<Entry>? currentEntryByDate,
    List<Entry>? records,
    bool? isLoading,
  }) {
    return RecordState(
        currentDateTime: currentDateTime ?? this.currentDateTime,
        currentEntryByDate: currentEntryByDate ?? this.currentEntryByDate,
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records
    );
  }
}
