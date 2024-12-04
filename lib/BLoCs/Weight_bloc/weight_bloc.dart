import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt_34/BLoCs/Weight_bloc/weight_event.dart';
import 'package:tt_34/BLoCs/Weight_bloc/weight_state.dart';
import '../../Repo/weight_repo.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final CurEntryRepository _curEntryRepository;

  EntryBloc(this._curEntryRepository) : super(EntryState()) {
    _initializePreferences();

    on<FetchCurEntriesEvent>((event, emit) async {
      final entries = await _curEntryRepository.fetchCurEntries();
      emit(EntryState(
        goalEntries: state.goalEntries,
        curEntries: entries,
        startEntries: state.startEntries,
      ));
    });

    on<AddCurEntryEvent>((event, emit) async {
      await _curEntryRepository.addCurEntry(event.entry);
      final entries = await _curEntryRepository.fetchCurEntries();
      emit(EntryState(
        goalEntries: state.goalEntries,
        curEntries: entries,
        startEntries: state.startEntries,
      ));
    });

    on<SaveWeightsEvent>((event, emit) async {
      await _saveWeights(event.startWeight, event.goalWeight);
      emit(EntryState(
        goalEntries: event.goalWeight,
        curEntries: state.curEntries,
        startEntries: event.startWeight,
      ));
    });
  }

  Future<void> _initializePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final goalWeight = prefs.getDouble('goalWeight') ?? 0.0;
    final startWeight = prefs.getDouble('startWeight') ?? 0.0;

    emit(EntryState(
      goalEntries: goalWeight,
      curEntries: state.curEntries,
      startEntries: startWeight,
    ));
  }

  Future<void> _saveWeights(double startWeight, double goalWeight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('startWeight', startWeight);
    await prefs.setDouble('goalWeight', goalWeight);
  }
}
