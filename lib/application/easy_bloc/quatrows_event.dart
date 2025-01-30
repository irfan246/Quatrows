part of 'quatrows_bloc.dart';

abstract class QuatrowsEvent {}

class StartGameEvent extends QuatrowsEvent {}

class SelectEvent extends QuatrowsEvent {
  final String selectText;

  SelectEvent(this.selectText);
}

class CheckAnswerEvent extends QuatrowsEvent {}

class CancelSelectionEvent extends QuatrowsEvent {}

class ResetGameEvent extends QuatrowsEvent {}
