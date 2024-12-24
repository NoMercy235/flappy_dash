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
  late TextComponent _score;
  late RandomNumberGenerator rngPipeDistance;
  late RandomNumberGenerator rngPipeGapPosition;
  late RandomNumberGenerator rngPipeGapSize;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _setupRngPipeDistance();
    _setupRngPipeGapPosition();
    _setupRngPipeGapSize();
    _setupText();
    _dash = Dash();

    add(DashParallaxBackground());
    // add(_clickToPlay);

    await add(
      FlameBlocListener<GameCubit, GameState>(
        onNewState: (state) {
          add(_dash);
          _dash.jump();
          generateNewPipe();
          game.camera.viewfinder.add(_score);
        },
        listenWhen: (prevState, newState) =>
            newState.currentPlayingState == PlayingState.playing &&
            prevState.currentPlayingState != newState.currentPlayingState,
      ),
    );

    await add(
      FlameBlocListener<GameCubit, GameState>(
        onNewState: (state) {
          _score.removeFromParent();
        },
        listenWhen: (prevState, newState) =>
            newState.currentPlayingState == PlayingState.gameOver &&
            prevState.currentPlayingState != newState.currentPlayingState,
      ),
    );
  }

  @override
  void update(double dt) {
    _score.text = "${bloc.state.currentScore}";
    super.update(dt);
  }

  void onSpaceDown() {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.none:
      case PlayingState.gameOver:
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

  _setupText() {
    _score = TextComponent(
      text: "${bloc.state.currentScore}",
      position: Vector2(0, -(game.size.y / 2)),
    );
  }
}
