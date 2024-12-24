// ignore_for_file: library_private_types_in_public_api

import 'package:flame/components.dart';

class Constants {
  static bool isDebugMode = false;

  // Player Movement
  static Vector2 gravity = Vector2(0, 35);
  static Vector2 jumpForce = Vector2(0, -12.5);

  static _CamSize camSize = _CamSize();
  static _PlayerSize playerSize = _PlayerSize();

  static _Files files = _Files();
  static _ParallaxSpeed parallaxSpeed = _ParallaxSpeed();

  const Constants._(); // Private constructor to prevent instantiation
}

class _CamSize {
  double width = 600;
  double height = 1000;
}

class _PlayerSize {
  double width = 80;
  double height = 80;
}

class _Files {
  String dash = 'dash.png';
  String layer1Sky = 'background/layer1-sky.png';
  String layer2Clouds = 'background/layer2-clouds.png';
  String layer3Clouds = 'background/layer3-clouds.png';
  String layer4Clouds = 'background/layer4-clouds.png';
  String layer5HugeClouds = 'background/layer5-huge-clouds.png';
  String layer6Bushes = 'background/layer6-bushes.png';
  String layer7Bushes = 'background/layer7-bushes.png';
}

class _ParallaxSpeed {
  Vector2 baseVelocity = Vector2(1, 0);
  Vector2 velocityMultiplierDelta = Vector2(1.7, 0);
}
