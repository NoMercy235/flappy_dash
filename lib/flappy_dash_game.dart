import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/dash_parallax_background.dart';
import 'package:flappy_dash/components/pipe_pair.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flappy_dash/utils/random_number_generator.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld> with KeyboardEvents {
  FlappyDashGame()
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

  void handlePlayerDead() {
    paused = true;
    // TODO: use game.camera.viewfinder.zoom = 0.2 when dying.
    world.generateNewPipe();
  }
}

class FlappyDashWorld extends World with TapCallbacks, HasCollisionDetection {
  late Dash dash;
  late RandomNumberGenerator rngPipeDistance;
  late RandomNumberGenerator rngPipeGapPosition;
  late RandomNumberGenerator rngPipeGapSize;

  @override
  FutureOr<void> onLoad() {
    _setupRngPipeDistance();
    _setupRngPipeGapPosition();
    _setupRngPipeGapSize();
    dash = Dash();

    add(DashParallaxBackground());
    add(dash);
    add(PipePair(
      position: Vector2(
        rngPipeDistance.getNumber(),
        rngPipeGapPosition.getNumber(),
      ),
      gap: rngPipeGapSize.getNumber(),
    ));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    dash.jump();
    super.onTapDown(event);
  }

  void onSpaceDown() {
    dash.jump();
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
