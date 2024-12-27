import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/components/dash.dart';
import 'package:flappy_dash/presentation/components/pipe.dart';
import 'package:flappy_dash/extensions/has_debug_watch.dart';
import 'package:flappy_dash/extensions/is_playable.dart';
import 'package:flappy_dash/presentation/flappy_dash_game.dart';
import 'package:flappy_dash/utils/constants.dart';

class PipePair extends PositionComponent
    with
        HasDebugWatch,
        CollisionCallbacks,
        HasGameRef<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState>,
        IsPlayable {
  final double gap;
  final double speed;
  PipePair({
    super.position,
    required this.gap,
    this.speed = Constants.pipeSpeed,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll([
      Pipe(position: Vector2(0, gap / 2), isFlipped: false),
      Pipe(position: Vector2(0, -(gap / 2)), isFlipped: true),
    ]);
    add(RectangleHitbox(
      position: Vector2(0, -(gap / 2)),
      size: Vector2(Constants.pipePairHitboxWidth, gap),
      anchor: Anchor.topCenter,
    ));

    await add(
      FlameBlocListener<GameCubit, GameState>(
        onNewState: (state) {
          removeFromParent();
        },
        listenWhen: (prevState, newState) =>
            newState.currentPlayingState == PlayingState.playing &&
            prevState.currentPlayingState != newState.currentPlayingState,
      ),
    );
  }

  @override
  void updateForPlayable(double dt) {
    position.x += speed * dt;

    if (position.x <= Constants.pipeOutOfPlayXBoundary) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Dash) {
      game.handlePlayerPassedPipePair();
      bloc.increaseScore();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
