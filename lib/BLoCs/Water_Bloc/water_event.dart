import 'package:tt_34/Models/water_model.dart';


abstract class WaterEvent {}

class LoadWaterEntriesEvent extends WaterEvent {
  final DateTime date;
  LoadWaterEntriesEvent(this.date);
}

class AddWaterEntryEvent extends WaterEvent {
  final int cups; // Number of cups to add
  AddWaterEntryEvent(this.cups);
}

class ResetWaterEntryEvent extends WaterEvent {}

class ChangeDateEvent extends WaterEvent {
  final int days;

  ChangeDateEvent(this.days);
}