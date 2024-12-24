import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = BlocProvider.of<GameCubit>(context);

    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Constants.fontSize,
              ),
            ),
            Text(
              'Score: ${gameCubit.state.currentScore}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Constants.fontSize,
              ),
            ),
            ElevatedButton(
              child: Text("Play Again"),
              onPressed: () {
                gameCubit.reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
