import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/dash_parallax_background.dart';
import 'package:flappy_dash/utils/constants.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld> {
  FlappyDashGame()
      : super(
          world: FlappyDashWorld(),
          camera: CameraComponent.withFixedResolution(
            width: Constants.camSize.width,
            height: Constants.camSize.height,
          ),
        );
}

class FlappyDashWorld extends World {
  @override
  FutureOr<void> onLoad() {
    add(DashParallaxBackground());
    add(Dash());
    return super.onLoad();
  }
}
