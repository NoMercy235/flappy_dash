// ignore_for_file: library_private_types_in_public_api

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Constants {
  // Debug
  static bool isDebugMode = false;
  static bool suspendDash = false;
  static bool isGodMode = false;
  static double cameraZoomInDebug = 0.65;

  // Speeds
  static Vector2 gravity = Vector2(0, 1400);
  static Vector2 jumpForce = Vector2(0, -500);
  static const double pipeSpeed = -180;
  static _ParallaxSpeed parallaxSpeed = _ParallaxSpeed();

  // Sizes
  static Vector2 pipeSize = Vector2(82, 100);
  static double pipePairHitboxWidth = 20;
  static _CamSize camSize = _CamSize();
  static _PlayerSize playerSize = _PlayerSize();

  static _UI ui = _UI();
  static _Files files = _Files();

  static double pipeOutOfPlayXBoundary = -400;

  static (double, double, double) distanceBetweenPipes = (400, 480, 10);
  static (double, double, double) pipeGapPosition = (-300, 300, 20);
  static (double, double, double) pipeGapSize = (200, 360, 20);

  static double gameOverMenuSoundLevel = 0.3;
  static Duration gameOverMenuSoundLevelFadeDuration = Duration(seconds: 1);

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

class _UI {
  double backgroundSigmaFilter = 2;
  double menuItemsSpacing = 20;

  double paddingNormal = 24;

  _Fonts fonts = _Fonts();
  _Colors colors = _Colors();
  _Animations animations = _Animations();
}

class _Fonts {
  double letterSpacingSmall = 2;
  double letterSpacing = 4;
  String mainFont = 'Chewy';

  double sizeSmall = 28;
  double sizeNormal = 38;
  double sizeLarge = 48;
}

class _Colors {
  Color mainText = Color(0Xff2387fc);
  Color secondaryText = Color(0xffffca00);
  Color bgLayer = Colors.black54;
}

class _Animations {
  double scaleAnimationBegin = 1.0;
  double scaleAnimationEnd = 1.2;
  Duration scaleAnimationDuration = Duration(seconds: 1);
}
