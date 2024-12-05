import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_event.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_state.dart';
import 'package:tt_34/Models/water_model.dart';
import '../../Repo/water_repo.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final WaterEntryRepository repository;
  DateTime _currentDate = DateTime.now();
  int totalCups = -1;

  WaterBloc(this.repository) : super(WaterInitialState()) {
    on<LoadWaterEntriesEvent>((event, emit) async {
      emit(WaterLoadingState());
      try {
        final entries = await repository.getWaterEntryByDate(event.date);
        totalCups = entries.fold(
            -1, (sum, entry) => sum + entry.amount); // Calculate total cups
        emit(WaterEntriesLoadedState(
            entries, event.date, totalCups)); // Update with total cups
      } catch (e) {
        emit(WaterErrorState('Failed to load water entries'));
      }
    });

    on<AddWaterEntryEvent>((event, emit) async {
      final waterEntry = WaterEntry(amount: event.cups, date: _currentDate);
      await repository.addWaterEntry(waterEntry);
      totalCups += event.cups; // Update current cups
      emit(WaterEntriesLoadedState(
          [], _currentDate, totalCups)); // Emit updated state
      add(LoadWaterEntriesEvent(
          _currentDate)); // Reload entries to reflect changes
    });

    on<ResetWaterEntryEvent>((event, emit) {
      totalCups = -1; // Reset total cups
      emit(WaterEntriesLoadedState(
          [], _currentDate, totalCups)); // Emit reset state
    });

    on<ChangeDateEvent>((event, emit) {
      _currentDate = _currentDate.add(Duration(days: event.days));
      totalCups = -1; // Reset cups when changing date
      emit(WaterEntriesLoadedState(
          [], _currentDate, totalCups)); // Emit reset state
      add(LoadWaterEntriesEvent(_currentDate)); // Load entries for the new date
    });
  }
}
