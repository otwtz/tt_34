import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_event.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_state.dart';

import '../../Repo/water_repo.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final DatabaseHelperWater databaseHelper;

  WaterBloc(this.databaseHelper) : super(WaterInitialState()) {
    on<AddWaterEntryEvent>((event, emit) async {
      await databaseHelper.insertWaterEntry(event.entry);
    });

    DateTime _getStartOfWeek(DateTime date) {
      return date.subtract(Duration(days: date.weekday - 1));
    }
    on<LoadWaterEntriesEvent>((event, emit) async {
      emit(WaterInitialState()); // Emit loading state
      try {
        DateTime startOfWeek = _getStartOfWeek(DateTime.now());
        final entries = await databaseHelper.getWaterEntriesForWeek(startOfWeek);
        emit(WaterEntriesLoadedState(entries)); // Emit loaded state
      } catch (e) {
        emit(WaterErrorState("Failed to load water entries")); // Emit error state
      }
    });

// Helper method to get the start of the week

  }
}
