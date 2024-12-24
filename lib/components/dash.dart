import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flappy_dash/extensions/has_debug_watch.dart';
import 'package:flappy_dash/utils/constants.dart';

// Could use SpriteComponent instead
class Dash extends PositionComponent with HasDebugWatch {
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
  FutureOr<void> onLoad() async {
    _sprite = await Sprite.load(Constants.files.dash);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _velocity += Constants.gravity * dt;
    position += _velocity;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: size);
    super.render(canvas);
  }

  void jump() {
    _velocity = Constants.jumpForce;
  }
}
