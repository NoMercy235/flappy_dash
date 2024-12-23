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

  @override
  FutureOr<void> onLoad() async {
    _sprite = await Sprite.load(Constants.files.dash);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: size);
    super.render(canvas);
  }
}
