import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tt_34/Models/entry_model.dart';

import '../../Repo/entry_repo.dart';
import 'entry_event.dart';
import 'entry_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final RecordRepository repository;

  RecordBloc(this.repository) : super(RecordState.initial()) {
    on<AddRecordEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await repository.addRecord(event.record);
      final records = await repository.getAllRecords();
      emit(state.copyWith(
          records: records, isLoading: false, currentEntryByDate: records));
      add(GetRecordsByDateEvent(state.currentDateTime ?? DateTime.now()));
    });

    on<LoadRecordEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final records = await repository.getAllRecords();
      if (state.currentEntryByDate.isEmpty ||
          state.currentEntryByDate.length != records.length) {
        emit(
          state.copyWith(
            records: records,
            isLoading: false,
            currentEntryByDate: records,
          ),
        );
      } else {
        List<Entry> currentEntryByDate = state.currentEntryByDate;
        for (int i = 0; i < currentEntryByDate.length; i++) {
          if (currentEntryByDate[i] != records[i]) {
            currentEntryByDate[i] = records[i];
          }
        }
        emit(state.copyWith(
          records: records,
          isLoading: false,
          currentEntryByDate: currentEntryByDate,
        ));
      }
      add(GetRecordsByDateEvent(state.currentDateTime ?? DateTime.now()));
    });

    on<UpdateRecordEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await repository.updateRecord(event.record);
      final records = await repository.getAllRecords();
      emit(state.copyWith(
          records: records, isLoading: false, currentEntryByDate: records));
    });

    on<DeleteRecordEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await repository.deleteRecord(event.id);
      final records = await repository.getAllRecords();
      emit(state.copyWith(
          records: records, isLoading: false, currentEntryByDate: records));
    });

    on<GetRecordsByDateEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final currentEntriesByDate =
          _filterEntriesByDate(date: event.date, entries: state.records);
      emit(state.copyWith(
          currentEntryByDate: currentEntriesByDate,
          isLoading: false,
          currentDateTime: event.date));
    });

    add(GetRecordsByDateEvent(DateTime.now()));
  }

  List<Entry> _filterEntriesByDate({
    required DateTime date,
    required List<Entry> entries,
  }) {
    return entries.where((entries) {
      return entries.date.year == date.year &&
          entries.date.month == date.month &&
          entries.date.day == date.day;
    }).toList();
  }
}
