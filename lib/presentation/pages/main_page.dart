import 'package:flame/game.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/flappy_dash_game.dart';
import 'package:flappy_dash/presentation/widgets/common/box_overlay.dart';
import 'package:flappy_dash/presentation/widgets/buttons/best_score_btn.dart';
import 'package:flappy_dash/presentation/widgets/game_over.dart';
import 'package:flappy_dash/presentation/widgets/buttons/press_to_start.dart';
import 'package:flappy_dash/presentation/widgets/buttons/profile_btn.dart';
import 'package:flappy_dash/presentation/widgets/score_display.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FlappyDashGame _flappyDashGame;
  late GameCubit gameCubit;

  PlayingState? _latestPlayingState;

  @override
  void initState() {
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyDashGame = FlappyDashGame(gameCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.currentPlayingState == PlayingState.none &&
            _latestPlayingState == PlayingState.gameOver) {
          setState(() {
            _flappyDashGame = FlappyDashGame(gameCubit);
          });
        }

        _latestPlayingState = state.currentPlayingState;
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(
                game: _flappyDashGame,
                backgroundBuilder: (context) => Container(
                  color: Constants.ui.colors.bgColor,
                ),
              ),
              if (state.currentPlayingState.isGameOver) GameOverWidget(),
              if (state.currentPlayingState.isIdle) PressToStart(),
              if (state.currentPlayingState.isPlaying)
                ScoreDisplay(score: state.currentScore),
              Padding(
                padding: EdgeInsets.only(top: Constants.ui.paddingXxs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileBtn(),
                    BestScoreBtn(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
