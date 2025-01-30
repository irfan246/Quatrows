part of 'quatrows_bloc.dart';

abstract class QuatrowsState {}

class QuatrowsInitialState extends QuatrowsState {}

class QuatrowsLoadedState extends QuatrowsState {
  final List<String> listText;
  final List<String> selectedTexts;
  final bool? isCorrect;
  final int correctGroups;
  final int errors;

  QuatrowsLoadedState({
    required this.listText,
    this.selectedTexts = const [],
    this.isCorrect,
    this.correctGroups = 0,
    this.errors = 0,
  });
}

class QuatrowsCheckedState extends QuatrowsState {
  final bool isCorrect;

  QuatrowsCheckedState({required this.isCorrect});
}

class QuatrowsWinState extends QuatrowsState {}

class QuatrowsLoseState extends QuatrowsState {}
