import '../../Models/water_model.dart';

abstract class WaterState {}

class WaterInitialState extends WaterState {}

class WaterLoadingState extends WaterState {}

class WaterEntriesLoadedState extends WaterState {
  final List<WaterEntry> entries; // List of water entries for the week
  final DateTime currentDate;
  final int currentCups;

  WaterEntriesLoadedState(this.entries, this.currentDate, this.currentCups);
}

class WaterErrorState extends WaterState {
  final String message;

  WaterErrorState(this.message);
}
