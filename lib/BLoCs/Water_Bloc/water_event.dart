import '../../Models/water_model.dart';

abstract class WaterEvent {}

class AddWaterEntryEvent extends WaterEvent {
  final WaterEntry entry;

  AddWaterEntryEvent(this.entry);
}

class LoadWaterEntriesEvent extends WaterEvent {
  final DateTime date;

  LoadWaterEntriesEvent(this.date);
}