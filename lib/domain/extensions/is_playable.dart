import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';

mixin IsPlayable on FlameBlocReader<GameCubit, GameState>, Component {
  @override
  void update(double dt) {
    if (!bloc.state.currentPlayingState.isPlaying) {
      return;
    }
    updateForPlayable(dt);
    super.update(dt);
  }

  void updateForPlayable(double dt) {}
}
