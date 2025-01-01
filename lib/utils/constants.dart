// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Constants {
  // Debug
  static bool isDebugMode = kDebugMode;
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

  static _User user = _User();
  static _UI ui = _UI();
  static _Files files = _Files();

  static double pipeOutOfPlayXBoundary = -400;

  static (double, double, double) distanceBetweenPipes = (400, 480, 10);
  static (double, double, double) pipeGapPosition = (-300, 300, 20);
  static (double, double, double) pipeGapSize = (200, 360, 20);

  static double gameOverMenuSoundLevel = 0.05;
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

  String splash = 'assets/images/dash.png';

  String icProfile = 'assets/icons/ic_profile.svg';
  String icTrophy = 'assets/icons/ic_trophy.svg';
  String icClose = 'assets/icons/ic_close.svg';
}

class _ParallaxSpeed {
  Vector2 baseVelocity = Vector2(1, 0);
  Vector2 velocityMultiplierDelta = Vector2(1.7, 0);
}

class _UI {
  double backgroundSigmaFilter = 2;
  double menuItemsSpacing = 20;

  double paddingXxs = 8;
  double paddingSmall = 16;
  double paddingNormal = 24;
  double boxBorderRadius = 16;

  _Fonts fonts = _Fonts();
  _Colors colors = _Colors();
  _Animations animations = _Animations();
  _UISizes sizes = _UISizes();

  BoxShadow leaderBoardBoxShadow = BoxShadow(
    color: Colors.black,
    spreadRadius: 0.1,
    offset: Offset(0, 4),
  );
}

class _Fonts {
  double letterSpacingSmall = 2;
  double letterSpacing = 4;
  String mainFont = 'Chewy';

  double sizeXxs = 18;
  double sizeSmall = 28;
  double sizeNormal = 38;
  double sizeLarge = 48;
}

class _Colors {
  Color splashText = Color(0xFF25165F);
  Color mainText = Color(0Xff00fbff);
  Color secondaryText = Color(0xffffca00);
  Color whiteTextHighlighted = Color(0xfff1f1f1);
  Color whiteText = Color(0xffdad2d8);

  Color menuLayer = Colors.black54;
  Color leaderboardRowSeparator = Colors.white30;

  Color bgColor = Color(0xff0f8b8d);
  Color boxBgColor = Color(0x66000000);
  Color dialogBgColor = Color(0xff16425b);

  Color trophyGoldBgColor = Color(0xFFFFD700);
  Color trophyGoldTextColor = Color(0xFF1C1B1F);
  Color trophySilverBgColor = Color(0xFFC0C0C0);
  Color trophySilverTextColor = Color(0xFF1C1B1F);
  Color trophyBronzeBgColor = Color(0xFFCD7F32);
  Color trophyBronzeTextColor = Color(0xFF1C1B1F);
}

class _Animations {
  double scaleAnimationBegin = 1.0;
  double scaleAnimationEnd = 1.2;
  Duration scaleAnimationDuration = Duration(seconds: 1);
}

class _User {
  int maxDisplayNameLength = 12;

  String host = kIsWeb
      ? kDebugMode
          ? '127.0.0.1'
          : 'rigamo2.xyz'
      : Platform.environment['NAKAMA_SERVER_HOST'] ?? '127.0.0.1';

  String deviceId = 'test-device-id';

  String serverKey = kIsWeb
      ? 'defaultkey'
      : Platform.environment['NAKAMA_SERVER_KEY'] ?? 'defaultkey';

  String leaderboardName = 'main_leaderboard';
  String groupName = 'Flutter devs';
}

class _UISizes {
  double iconHeight = 32;
  double iconWidth = 32;
  double splashIconSize = 124;

  double spacingSmall = 16;
  double spacingNormal = 24;

  double nicknameSaveBtnWidth = 240;

  double dialogWidth = 400;

  double shadowWidth = 4;

  double leaderboardRowSeparatorHeight = 1;
  double leaderboardViewHeight = 400;

  EdgeInsets boxOverlayPadding = EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 8,
  );
  Alignment trophyNrAlignment = Alignment(0, -0.7);
}
