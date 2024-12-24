part of 'game_cubit.dart';

class GameState with EquatableMixin {
  final int currentScore;
  final PlayingState currentPlayingState;
  const GameState({
    this.currentScore = 0,
    this.currentPlayingState = PlayingState.none,
  });

  @override
  List<Object> get props => [
        currentScore,
        currentPlayingState,
      ];

  GameState copyWith({int? newScore, PlayingState? newPlayingState}) =>
      GameState(
        currentScore: newScore ?? currentScore,
        currentPlayingState: newPlayingState ?? currentPlayingState,
      );
}

enum PlayingState {
  none,
  playing,
  paused,
  gameOver,
}