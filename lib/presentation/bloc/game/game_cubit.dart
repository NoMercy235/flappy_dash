import 'package:equatable/equatable.dart';
import 'package:flappy_dash/domain/repositories/game_repository.dart';
import 'package:flappy_dash/utils/audio_helper.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakama/nakama.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final AudioHelper _audioHelper;
  final GameRepository _gameRepository;
  GameCubit(
    this._audioHelper,
    this._gameRepository,
  ) : super(GameState()) {
    _init();
  }

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
    _gameRepository.submitScore(
      Constants.user.leaderboardName,
      state.currentScore,
    );
    emit(state.copyWith(newPlayingState: PlayingState.gameOver));
  }

  void changeUsername(String username) async {
    await _gameRepository.changeUsername(username);
  }

  void refreshLeaderboard() async {
    final records = await _gameRepository.getLeaderboard(
      Constants.user.leaderboardName,
    );
    emit(state.copyWith(
      newLeaderboardRecordList: records,
    ));
  }

  void _init() async {
    final records = await _gameRepository.getLeaderboard(
      Constants.user.leaderboardName,
    );
    final account = await _gameRepository.getCurrentUserAccount();

    emit(state.copyWith(
      newLeaderboardRecordList: records,
      newUserAccount: account,
    ));
  }
}
