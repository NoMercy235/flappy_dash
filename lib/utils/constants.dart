// ignore_for_file: library_private_types_in_public_api

import 'package:flame/components.dart';

class Constants {
  // Debug
  static bool isDebugMode = true;
  static bool suspendDash = false;
  static bool isGodMode = false;
  static double cameraZoomInDebug = 0.65;

  // Speeds
  static Vector2 gravity = Vector2(0, 35);
  static Vector2 jumpForce = Vector2(0, -11);
  static const double pipeSpeed = -150;
  static _ParallaxSpeed parallaxSpeed = _ParallaxSpeed();

  // Sizes
  static Vector2 pipeSize = Vector2(82, 100);
  static double pipePairHitboxWidth = 20;
  static _CamSize camSize = _CamSize();
  static _PlayerSize playerSize = _PlayerSize();

  static _Files files = _Files();

  static (double, double, double) distanceBetweenPipes = (400, 480, 10);
  static (double, double, double) pipeGapPosition = (-300, 300, 20);
  static (double, double, double) pipeGapSize = (200, 360, 20);

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
