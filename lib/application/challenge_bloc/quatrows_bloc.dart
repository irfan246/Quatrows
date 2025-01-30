import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quatrows/infrastructure/local_database_indo.dart';
import 'package:quatrows/infrastructure/local_database_inggris.dart';
import 'package:quatrows/infrastructure/local_database_ipa.dart';
import 'package:quatrows/infrastructure/local_database_ips.dart';
import 'package:quatrows/infrastructure/local_database_mtk.dart';

part 'quatrows_event.dart';
part 'quatrows_state.dart';

class QuatrowsChallengeBloc
    extends Bloc<QuatrowsEventChallenge, QuatrowsStateChallenge> {
  Timer? _timer;
  static const int _duration = 120;
  final Random random = Random();
  int _remainingTime = _duration;

  QuatrowsChallengeBloc() : super(QuatrowsChallengeLoadedState(listText: [])) {
    on<StartGameEventChallenge>(_onStartGame);
    on<SelectEvent>(_onSelect);
    on<CheckAnswerEvent>(_onCheckAnswer);
    on<CancelSelectionEvent>(_onCancelSelection);
    on<ResetGameChallengeEvent>(_onResetGame);
    on<TimerTickEvent>(_onTimerTick);
  }

  void _onStartGame(
      StartGameEventChallenge event, Emitter<QuatrowsStateChallenge> emit) {
    _startTimer();
    List<List<String>> databases = [
      (indonesiaData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (inggrisData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (ipaData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (ipsData..shuffle(random)).take(4).map((e) => e.text).toList(),
      (matematikaData..shuffle(random)).take(4).map((e) => e.text).toList(),
    ];

    databases.shuffle(random);
    List<String> selectedData = databases.take(4).expand((e) => e).toList();

    if (selectedData.isNotEmpty) {
      selectedData.shuffle(random);
      emit(QuatrowsChallengeLoadedState(
          listText: selectedData, timer: _remainingTime));
    } else {
      emit(QuatrowsChallengeLoadedState(listText: [], timer: _remainingTime));
    }
  }

  void _onSelect(SelectEvent event, Emitter<QuatrowsStateChallenge> emit) {
    if (state is QuatrowsChallengeLoadedState) {
      final currentState = state as QuatrowsChallengeLoadedState;
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

      emit(QuatrowsChallengeLoadedState(
        listText: currentState.listText,
        selectedTexts: selectedTexts,
        correctGroups: currentState.correctGroups,
        errors: currentState.errors,
        timer: currentState.timer,
      ));
    }
  }

  void _onCheckAnswer(
      CheckAnswerEvent event, Emitter<QuatrowsStateChallenge> emit) {
    if (state is QuatrowsChallengeLoadedState) {
      final currentState = state as QuatrowsChallengeLoadedState;
      final selectedTexts = currentState.selectedTexts;

      // Ensure exactly 4 buttons are selected
      if (selectedTexts.length != 4) {
        emit(QuatrowsChallengeLoadedState(
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
          emit(QuatrowsWinChallengeState());
        } else {
          emit(QuatrowsChallengeLoadedState(
              listText: newListText,
              selectedTexts: [],
              correctGroups: currentState.correctGroups + 1,
              errors: currentState.errors,
              timer: currentState.timer));
        }
      } else {
        if (currentState.errors + 1 >= 3) {
          emit(QuatrowsLoseChallengeState());
        } else {
          emit(QuatrowsChallengeLoadedState(
              listText: currentState.listText,
              selectedTexts: [],
              isCorrect: false,
              correctGroups: currentState.correctGroups,
              errors: currentState.errors + 1,
              timer: currentState.timer));
        }
      }
    }
  }

  void _onCancelSelection(
      CancelSelectionEvent event, Emitter<QuatrowsStateChallenge> emit) {
    if (state is QuatrowsChallengeLoadedState) {
      final currentState = state as QuatrowsChallengeLoadedState;
      emit(QuatrowsChallengeLoadedState(
        listText: currentState.listText,
        selectedTexts: [],
        correctGroups: currentState.correctGroups,
        errors: currentState.errors,
        timer: currentState.timer,
      ));
    }
  }

  void _onResetGame(
      ResetGameChallengeEvent event, Emitter<QuatrowsStateChallenge> emit) {
    _timer?.cancel();
    _remainingTime = _duration;
    add(StartGameEventChallenge());
    emit(QuatrowsChallengeLoadedState(listText: [], timer: _remainingTime));
  }

  void _onTimerTick(
      TimerTickEvent event, Emitter<QuatrowsStateChallenge> emit) {
    final currentState = state;
    if (currentState is QuatrowsChallengeLoadedState) {
      final newTimer = currentState.timer - 1;
      if (newTimer <= 0) {
        _timer?.cancel();
        emit(QuatrowsLoseChallengeState());
      } else {
        emit(QuatrowsChallengeLoadedState(
          listText: currentState.listText,
          selectedTexts: currentState.selectedTexts,
          isCorrect: currentState.isCorrect,
          correctGroups: currentState.correctGroups,
          errors: currentState.errors,
          timer: newTimer,
        ));
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(TimerTickEvent());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
