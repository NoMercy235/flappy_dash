import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/dash_parallax_background.dart';
import 'package:flappy_dash/components/pipe_pair.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flappy_dash/utils/random_number_generator.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld> with KeyboardEvents {
  GameCubit gameCubit;
  FlappyDashGame(this.gameCubit)
      : super(
          world: FlappyDashWorld(),
          camera: CameraComponent.withFixedResolution(
            width: Constants.camSize.width,
            height: Constants.camSize.height,
          ),
        );

  @override
  FutureOr<void> onLoad() {
    if (Constants.isDebugMode) {
      camera.viewfinder.zoom = Constants.cameraZoomInDebug;
    }
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    final isP = keysPressed.contains(LogicalKeyboardKey.keyP);

    if (isP) {
      paused = !paused;
    }

    if (isSpace && isKeyDown) {
      world.onSpaceDown();
      return KeyEventResult.handled;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void handlePlayerPassedPipePair() {
    world.generateNewPipe();
  }
}

class FlappyDashWorld extends World
    with TapCallbacks, HasGameRef<FlappyDashGame> {
  late FlappyDashRootComponent _rootComponent;

  @override
  FutureOr<void> onLoad() {
    add(FlameBlocProvider<GameCubit, GameState>(
      create: () => game.gameCubit,
      children: [
        _rootComponent = FlappyDashRootComponent(),
      ],
    ));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    _rootComponent.onSpaceDown();
    super.onTapDown(event);
  }

  void onSpaceDown() {
    _rootComponent.onSpaceDown();
  }

  void generateNewPipe() {
    _rootComponent.generateNewPipe();
  }
}

class FlappyDashRootComponent extends Component
    with
        HasGameRef<FlappyDashGame>,
        HasCollisionDetection,
        FlameBlocReader<GameCubit, GameState> {
  late Dash _dash;
  late TextComponent _score;
  late TextComponent _clickToPlay;
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
    add(_clickToPlay);

    await add(
      FlameBlocListener<GameCubit, GameState>(
        onNewState: (state) {
          _dash.reset();
          add(_dash);
          _dash.jump();
          generateNewPipe();
          _clickToPlay.removeFromParent();
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
    _clickToPlay = TextComponent(
      text: "Click or press Space to start",
      position: Vector2.zero(),
      anchor: Anchor.center,
    );

    _score = TextComponent(
      text: "${bloc.state.currentScore}",
      position: Vector2(0, -(game.size.y / 2)),
    );
  }
}
