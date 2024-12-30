import 'package:equatable/equatable.dart';
import 'package:flappy_dash/domain/entities/leaderboard_entity.dart';
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

  void gameOver() async {
    _audioHelper.stopBgAudio();
    emit(state.copyWith(newPlayingState: PlayingState.gameOver));
    try {
      await _gameRepository.submitScore(
        Constants.user.leaderboardName,
        state.currentScore,
      );
    } catch (err) {
      print("failed to upload new score: $err");
    }
    await _updateLeaderboard();
  }

  void changeDisplayName(String displayName) async {
    await _gameRepository.changeDisplayName(displayName);
    await Future.delayed(const Duration(seconds: 1));
    final account = await _gameRepository.getCurrentUserAccount();
    emit(state.copyWith(
      newUserAccount: account,
    ));
  }

  void refreshLeaderboard() async {
    await _updateLeaderboard();
  }

  void _init() async {
    await _updateLeaderboard();
    await _refreshCurrentUserAccount();
  }

  Future<void> _updateLeaderboard() async {
    final leaderboard = await _gameRepository.getLeaderboard(
      Constants.user.leaderboardName,
    );
    emit(state.copyWith(newLeaderboard: leaderboard));
  }

  Future<void> _refreshCurrentUserAccount() async {
    final account = await _gameRepository.getCurrentUserAccount();
    emit(state.copyWith(newUserAccount: account));
  }
}
