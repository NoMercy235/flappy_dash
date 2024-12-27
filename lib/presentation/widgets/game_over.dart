import 'dart:ui';

import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = BlocProvider.of<GameCubit>(context);

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Constants.ui.backgroundSigmaFilter,
        sigmaY: Constants.ui.backgroundSigmaFilter,
      ),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: Constants.ui.menuItemsSpacing,
            children: [
              Text(
                'Game Over',
                style: TextStyle(
                  color: Constants.ui.colors.secondaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.ui.fonts.sizeLarge,
                  letterSpacing: Constants.ui.fonts.letterSpacing,
                ),
              ),
              Text(
                'Score: ${gameCubit.state.currentScore}',
                style: TextStyle(
                  color: Constants.ui.colors.secondaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.ui.fonts.sizeSmall,
                  letterSpacing: Constants.ui.fonts.letterSpacing,
                ),
              ),
              const SizedBox(),
              ElevatedButton(
                child: Text(
                  "Play Again",
                  style: TextStyle(
                      color: Constants.ui.colors.mainText,
                      letterSpacing: Constants.ui.fonts.letterSpacingSmall,
                      fontSize: Constants.ui.fonts.sizeSmall),
                ),
                onPressed: () {
                  gameCubit.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
