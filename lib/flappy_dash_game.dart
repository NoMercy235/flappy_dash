import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/dash_parallax_background.dart';
import 'package:flappy_dash/utils/constants.dart';
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
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      world.onSpaceDown();
      return KeyEventResult.handled;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}

class FlappyDashWorld extends World with TapCallbacks {
  late Dash dash;
  @override
  FutureOr<void> onLoad() {
    dash = Dash();

    add(DashParallaxBackground());
    add(dash);
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
}
