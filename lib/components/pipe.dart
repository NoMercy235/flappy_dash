import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/extensions/has_debug_watch.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flappy_dash/utils/constants.dart';

class Pipe extends SpriteComponent
    with HasDebugWatch, CollisionCallbacks, HasGameRef<FlappyDashGame> {
  final bool isFlipped;
  Pipe({required super.position, required this.isFlipped});

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('pipe.png');
    anchor = Anchor.topCenter;

    final ratio = sprite!.srcSize.y / sprite!.srcSize.x;
    size = Constants.pipeSize;
    size.y *= ratio;

    if (isFlipped) {
      flipVertically();
    }

    add(RectangleHitbox(
      // position: position,
      size: size,
      anchor: Anchor.topLeft,
    ));

    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Dash && !Constants.isGodMode) {
      game.handlePlayerDead();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
