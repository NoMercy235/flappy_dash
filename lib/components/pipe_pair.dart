import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/pipe.dart';
import 'package:flappy_dash/extensions/has_debug_watch.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flappy_dash/utils/constants.dart';

class PipePair extends PositionComponent
    with HasDebugWatch, CollisionCallbacks, HasGameRef<FlappyDashGame> {
  final double gap;
  final double speed;
  PipePair({
    super.position,
    required this.gap,
    this.speed = Constants.pipeSpeed,
  });

  @override
  FutureOr<void> onLoad() {
    addAll([
      Pipe(position: Vector2(0, gap / 2), isFlipped: false),
      Pipe(position: Vector2(0, -(gap / 2)), isFlipped: true),
    ]);
    add(RectangleHitbox(
      position: Vector2(0, -(gap / 2)),
      size: Vector2(Constants.pipePairHitboxWidth, gap),
      anchor: Anchor.topCenter,
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x += speed * dt;

    if (position.x <= -400) {
      removeFromParent();
    }

    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Dash) {
      game.handlePlayerPassedPipePair();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
