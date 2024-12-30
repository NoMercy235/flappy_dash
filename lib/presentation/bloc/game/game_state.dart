part of 'game_cubit.dart';

class GameState with EquatableMixin {
  final int currentScore;
  final PlayingState currentPlayingState;
  final LeaderboardEntity? currentLeaderboard;
  final Account? currentUserAccount;
  const GameState({
    this.currentScore = 0,
    this.currentPlayingState = PlayingState.none,
    this.currentLeaderboard,
    this.currentUserAccount,
  });

  @override
  List<Object?> get props => [
        currentScore,
        currentPlayingState,
        currentLeaderboard ?? [],
        currentUserAccount,
      ];

  GameState copyWith({
    int? newScore,
    PlayingState? newPlayingState,
    LeaderboardEntity? newLeaderboard,
    Account? newUserAccount,
  }) =>
      GameState(
        currentScore: newScore ?? currentScore,
        currentPlayingState: newPlayingState ?? currentPlayingState,
        currentLeaderboard: newLeaderboard ?? currentLeaderboard,
        currentUserAccount: newUserAccount ?? currentUserAccount,
      );
}

enum PlayingState {
  none,
  playing,
  paused,
  gameOver,
  ;

  bool get isPlaying => this == PlayingState.playing;
  bool get isGameOver => this == PlayingState.gameOver;
  bool get isIdle => this == PlayingState.none;
  bool get isPaused => this == PlayingState.paused;
}
