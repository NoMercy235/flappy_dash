import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_dash/presentation/flappy_dash_game.dart';
import 'package:flappy_dash/utils/constants.dart';

class DashParallaxBackground extends ParallaxComponent<FlappyDashGame> {
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    parallax = await game.loadParallax(
      [
        ParallaxImageData(Constants.files.layer1Sky),
        ParallaxImageData(Constants.files.layer2Clouds),
        ParallaxImageData(Constants.files.layer3Clouds),
        ParallaxImageData(Constants.files.layer4Clouds),
        ParallaxImageData(Constants.files.layer5HugeClouds),
        ParallaxImageData(Constants.files.layer6Bushes),
        ParallaxImageData(Constants.files.layer7Bushes),
      ],
      baseVelocity: Constants.parallaxSpeed.baseVelocity,
      velocityMultiplierDelta: Constants.parallaxSpeed.velocityMultiplierDelta,
    );
    return super.onLoad();
  }
}
