import '../../Models/entry_model.dart';

abstract class RecordEvent {}

class AddRecordEvent extends RecordEvent {
  final Entry record;

  AddRecordEvent(this.record);
}

class LoadRecordEvent extends RecordEvent {}

class UpdateRecordEvent extends RecordEvent {
  final Entry record;

  UpdateRecordEvent(this.record);
}

class DeleteRecordEvent extends RecordEvent {
  final int id;

  DeleteRecordEvent(this.id);
}

class GetRecordsByDateEvent extends RecordEvent {
  final DateTime date;

  GetRecordsByDateEvent(this.date);
}

class GetAllRecordsEvent extends RecordEvent {}

