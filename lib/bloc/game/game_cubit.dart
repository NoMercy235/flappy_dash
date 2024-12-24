import 'package:equatable/equatable.dart';
import 'package:flappy_dash/utils/audio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(
    this._audioHelper,
  ) : super(GameState());

  final AudioHelper _audioHelper;

  void startPlaying() {
    emit(state.copyWith(
      newPlayingState: PlayingState.playing,
      newScore: 0,
    ));
  }

  void reset() {
    _audioHelper.resumeBgAudio();
    emit(state.copyWith(
      newPlayingState: PlayingState.none,
      newScore: 0,
    ));
  }

  void increaseScore() {
    _audioHelper.playScoreAudio();
    emit(state.copyWith(newScore: state.currentScore + 1));
  }

  void gameOver() {
    _audioHelper.stopBgAudio();
    emit(state.copyWith(newPlayingState: PlayingState.gameOver));
  }
}
