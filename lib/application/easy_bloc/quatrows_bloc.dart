import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:quatrows/infrastructure/local_database_indo.dart';
import 'package:quatrows/infrastructure/local_database_inggris.dart';
import 'package:quatrows/infrastructure/local_database_ipa.dart';
import 'package:quatrows/infrastructure/local_database_ips.dart';
import 'package:quatrows/infrastructure/local_database_mtk.dart';

part 'quatrows_event.dart';
part 'quatrows_state.dart';

class QuatrowsBloc extends Bloc<QuatrowsEvent, QuatrowsState> {
  final Random random = Random();

  QuatrowsBloc() : super(QuatrowsInitialState()) {
    on<StartGameEvent>(_startGame);
    on<SelectEvent>(_selectText);
    on<CheckAnswerEvent>(_checkAnswer);
    on<CancelSelectionEvent>(_cancelSelection);
    on<ResetGameEvent>(_resetGame);
  }

  void _startGame(StartGameEvent event, Emitter<QuatrowsState> emit) {
    List<List<String>> databases = [
      (indonesiaData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (inggrisData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (ipaData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (ipsData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (matematikaData..shuffle(random)).take(4).map((e) => e.text).toList(),
    ];

    databases.shuffle(random);
    List<String> selectedData = databases.take(4).expand((e) => e).toList();

    selectedData.shuffle(random);

    emit(QuatrowsLoadedState(listText: selectedData));
  }

  void _selectText(SelectEvent event, Emitter<QuatrowsState> emit) {
    if (state is QuatrowsLoadedState) {
      final currentState = state as QuatrowsLoadedState;
      final selectedTexts = List<String>.from(currentState.selectedTexts);

      // Ensure only 4 buttons can be selected at a time
      if (selectedTexts.length < 4 ||
          selectedTexts.contains(event.selectText)) {
        if (selectedTexts.contains(event.selectText)) {
          selectedTexts.remove(event.selectText);
        } else {
          selectedTexts.add(event.selectText);
        }
      }

      emit(QuatrowsLoadedState(
        listText: currentState.listText,
        selectedTexts: selectedTexts,
        correctGroups: currentState.correctGroups,
        errors: currentState.errors,
      ));
    }
  }

  void _checkAnswer(CheckAnswerEvent event, Emitter<QuatrowsState> emit) {
    if (state is QuatrowsLoadedState) {
      final currentState = state as QuatrowsLoadedState;
      final selectedTexts = currentState.selectedTexts;

      // Ensure exactly 4 buttons are selected
      if (selectedTexts.length != 4) {
        emit(QuatrowsLoadedState(
          listText: currentState.listText,
          selectedTexts: selectedTexts,
          correctGroups: currentState.correctGroups,
          errors: currentState.errors + 1,
        ));
        return;
      }

      final allData = [
        indonesiaData.map((e) => e.text).toList(),
        inggrisData.map((e) => e.text).toList(),
        ipaData.map((e) => e.text).toList(),
        ipsData.map((e) => e.text).toList(),
        matematikaData.map((e) => e.text).toList(),
      ];

      bool isCorrect = allData
          .any((data) => selectedTexts.every((text) => data.contains(text)));

      if (isCorrect) {
        List<String> newListText = List.from(currentState.listText);
        newListText.removeWhere((text) => selectedTexts.contains(text));
        newListText.addAll(selectedTexts);

        if (currentState.correctGroups + 1 == 4) {
          emit(QuatrowsWinState());
        } else {
          emit(QuatrowsLoadedState(
            listText: newListText,
            selectedTexts: [],
            correctGroups: currentState.correctGroups + 1,
            errors: currentState.errors,
          ));
        }
      } else {
        if (currentState.errors + 1 >= 3) {
          emit(QuatrowsLoseState());
        } else {
          emit(QuatrowsLoadedState(
            listText: currentState.listText,
            selectedTexts: [],
            correctGroups: currentState.correctGroups,
            errors: currentState.errors + 1,
          ));
        }
      }
    }
  }

  void _cancelSelection(
      CancelSelectionEvent event, Emitter<QuatrowsState> emit) {
    if (state is QuatrowsLoadedState) {
      final currentState = state as QuatrowsLoadedState;
      emit(QuatrowsLoadedState(
        listText: currentState.listText,
        selectedTexts: [],
        correctGroups: currentState.correctGroups,
        errors: currentState.errors,
      ));
    }
  }

  void _resetGame(ResetGameEvent event, Emitter<QuatrowsState> emit) {
    add(StartGameEvent());
  }
}
