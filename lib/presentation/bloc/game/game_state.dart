part of 'game_cubit.dart';

class GameState with EquatableMixin {
  final int currentScore;
  final PlayingState currentPlayingState;
  final LeaderboardRecordList? currentLeaderboardRecordList;
  final Account? currentUserAccount;
  const GameState({
    this.currentScore = 0,
    this.currentPlayingState = PlayingState.none,
    this.currentLeaderboardRecordList,
    this.currentUserAccount,
  });

  @override
  List<Object?> get props => [
        currentScore,
        currentPlayingState,
        currentLeaderboardRecordList ?? [],
        currentUserAccount,
      ];

  GameState copyWith({
    int? newScore,
    PlayingState? newPlayingState,
    LeaderboardRecordList? newLeaderboardRecordList,
    Account? newUserAccount,
  }) =>
      GameState(
        currentScore: newScore ?? currentScore,
        currentPlayingState: newPlayingState ?? currentPlayingState,
        currentLeaderboardRecordList:
            newLeaderboardRecordList ?? currentLeaderboardRecordList,
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
