import 'package:equatable/equatable.dart';

import '../../Models/weight_model.dart';

// Базовый класс для событий
abstract class EntryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Событие для получения текущих записей
class FetchCurEntriesEvent extends EntryEvent {}

// Событие для добавления текущей записи
class AddCurEntryEvent extends EntryEvent {
  final CurEntry entry;

  AddCurEntryEvent(this.entry);

  @override
  List<Object?> get props => [entry];
}

// Событие для сохранения весов
class SaveWeightsEvent extends EntryEvent {
  final double startWeight;
  final double goalWeight;

  SaveWeightsEvent(this.startWeight, this.goalWeight);

  @override
  List<Object?> get props => [startWeight, goalWeight];
}

// Событие для получения записей целей (если необходимо)
class FetchGoalEntriesEvent extends EntryEvent {}

// Событие для добавления записи цели (если необходимо)
class AddGoalEntryEvent extends EntryEvent {
  final GoalEntry entry;

  AddGoalEntryEvent(this.entry);

  @override
  List<Object?> get props => [entry];
}

// Событие для получения стартовых записей (если необходимо)
class FetchStartEntriesEvent extends EntryEvent {}

// Событие для добавления стартовой записи (если необходимо)
class AddStartEntryEvent extends EntryEvent {
  final StartEntry entry;

  AddStartEntryEvent(this.entry);

  @override
  List<Object?> get props => [entry];
}