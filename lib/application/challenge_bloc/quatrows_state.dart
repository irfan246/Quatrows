part of 'quatrows_bloc.dart';

abstract class QuatrowsStateChallenge {}

class QuatrowsChallengeLoadedState extends QuatrowsStateChallenge {
  final List<String> listText;
  final List<String> selectedTexts;
  final bool? isCorrect;
  final int correctGroups;
  final int errors;
  final int timer;
  QuatrowsChallengeLoadedState({
    required this.listText,
    this.selectedTexts = const [],
    this.isCorrect,
    this.correctGroups = 0,
    this.errors = 0,
    this.timer = 120,
  });
}

class QuatrowsCheckedState extends QuatrowsStateChallenge {
  final bool isCorrect;

  QuatrowsCheckedState({required this.isCorrect});
}

class QuatrowsWinChallengeState extends QuatrowsStateChallenge {}

class QuatrowsLoseChallengeState extends QuatrowsStateChallenge {}
