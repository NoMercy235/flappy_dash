import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/dash_parallax_background.dart';
import 'package:flappy_dash/components/pipe_pair.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flappy_dash/utils/random_number_generator.dart';

class FlappyDashRootComponent extends Component
    with
        HasGameRef<FlappyDashGame>,
        HasCollisionDetection,
        FlameBlocReader<GameCubit, GameState> {
  late Dash _dash;
  late RandomNumberGenerator rngPipeDistance;
  late RandomNumberGenerator rngPipeGapPosition;
  late RandomNumberGenerator rngPipeGapSize;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _setupRngPipeDistance();
    _setupRngPipeGapPosition();
    _setupRngPipeGapSize();
    _dash = Dash();

    add(DashParallaxBackground());

    await add(
      FlameBlocListener<GameCubit, GameState>(
        onNewState: (state) {
          add(_dash);
          _dash.jump();
          generateNewPipe();
        },
        listenWhen: (prevState, newState) =>
            newState.currentPlayingState == PlayingState.playing &&
            prevState.currentPlayingState != newState.currentPlayingState,
      ),
    );
  }

  void onSpaceDown() {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.none:
        bloc.startPlaying();
        break;
      case PlayingState.playing:
        _dash.jump();
        break;
      default:
    }
  }

  void generateNewPipe() {
    add(PipePair(
      position: Vector2(
        rngPipeDistance.getNumber(),
        rngPipeGapPosition.getNumber(),
      ),
      gap: rngPipeGapSize.getNumber(),
    ));
  }

  _setupRngPipeDistance() {
    final (start, end, step) = Constants.distanceBetweenPipes;
    rngPipeDistance = RandomNumberGenerator(start: start, end: end, step: step);
  }

  _setupRngPipeGapPosition() {
    final (start, end, step) = Constants.pipeGapPosition;
    rngPipeGapPosition =
        RandomNumberGenerator(start: start, end: end, step: step);
  }

  _setupRngPipeGapSize() {
    final (start, end, step) = Constants.pipeGapSize;
    rngPipeGapSize = RandomNumberGenerator(start: start, end: end, step: step);
  }
}
