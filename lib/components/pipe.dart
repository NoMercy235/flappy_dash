import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/extensions/has_debug_watch.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flappy_dash/utils/constants.dart';

class Pipe extends SpriteComponent
    with
        HasDebugWatch,
        CollisionCallbacks,
        HasGameRef<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState> {
  final bool isFlipped;
  Pipe({required super.position, required this.isFlipped});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('pipe.png');
    anchor = Anchor.topCenter;

    final ratio = sprite!.srcSize.y / sprite!.srcSize.x;
    size = Constants.pipeSize;
    size.y *= ratio;

    if (isFlipped) {
      flipVertically();
    }

    add(RectangleHitbox(
      size: size,
      anchor: Anchor.topLeft,
    ));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Dash && !Constants.isGodMode) {
      bloc.gameOver();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
