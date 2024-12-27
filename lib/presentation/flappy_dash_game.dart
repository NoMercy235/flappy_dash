import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/components/flappy_dash_root.dart';
import 'package:flappy_dash/utils/audio_helper.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flappy_dash/utils/service_locator.dart';
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
  FutureOr<void> onLoad() async {
    await getIt.get<AudioHelper>().initialize();
    getIt.get<AudioHelper>().playBgAudio();

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
