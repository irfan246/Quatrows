part of 'quatrows_bloc.dart';

abstract class QuatrowsEventChallenge {}

class StartGameEventChallenge extends QuatrowsEventChallenge {}

class SelectEvent extends QuatrowsEventChallenge {
  final String selectText;

  SelectEvent(this.selectText);
}

class CheckAnswerEvent extends QuatrowsEventChallenge {}

class CancelSelectionEvent extends QuatrowsEventChallenge {}

class ResetGameChallengeEvent extends QuatrowsEventChallenge {}

class TimerTickEvent extends QuatrowsEventChallenge {} // Add TimerTickEvent
