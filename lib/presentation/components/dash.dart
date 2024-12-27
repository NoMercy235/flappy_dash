import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/extensions/has_debug_watch.dart';
import 'package:flappy_dash/extensions/is_playable.dart';
import 'package:flappy_dash/presentation/flappy_dash_game.dart';
import 'package:flappy_dash/utils/constants.dart';

// Could use SpriteComponent instead
class Dash extends PositionComponent
    with
        HasDebugWatch,
        CollisionCallbacks,
        HasGameRef<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState>,
        IsPlayable {
  Dash()
      : super(
          position: Vector2.zero(),
          size: Vector2(
            Constants.playerSize.width,
            Constants.playerSize.height,
          ),
          anchor: Anchor.center,
        );

  late Sprite _sprite;

  Vector2 _velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _sprite = await Sprite.load(Constants.files.dash);
    add(CircleHitbox(
        position: size / 2,
        radius: Constants.playerSize.width / 2 * 0.8,
        anchor: Anchor.center));
  }

  @override
  void updateForPlayable(double dt) {
    _velocity += Constants.gravity * dt;
    position += _velocity * dt;
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: size);
    super.render(canvas);
  }

  void jump() {
    _velocity = Constants.jumpForce;
  }

  void reset() {
    position = Vector2.zero();
    _velocity = Vector2.zero();
  }
}
