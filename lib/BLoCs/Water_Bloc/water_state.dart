import '../../Models/water_model.dart';

abstract class WaterState {}

class WaterInitialState extends WaterState {}

class WaterEntriesLoadedState extends WaterState {
  final List<WaterEntry> entries;

  WaterEntriesLoadedState(this.entries);
}

class WaterErrorState extends WaterState {
  final String message;

  WaterErrorState(this.message);
}
