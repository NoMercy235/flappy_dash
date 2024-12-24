import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState());

  void startPlaying() {
    emit(state.copyWith(
      newPlayingState: PlayingState.playing,
      newScore: 0,
    ));
  }

  void reset() {
    emit(state.copyWith(
      newPlayingState: PlayingState.none,
      newScore: 0,
    ));
  }

  void increaseScore() {
    emit(state.copyWith(newScore: state.currentScore + 1));
  }

  void gameOver() {
    emit(state.copyWith(newPlayingState: PlayingState.gameOver));
  }
}
