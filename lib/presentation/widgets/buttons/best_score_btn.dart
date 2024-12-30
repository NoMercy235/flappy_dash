import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/widgets/buttons/menu_btn_base.dart';
import 'package:flappy_dash/presentation/widgets/common/trophy.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestScoreBtn extends StatelessWidget {
  final VoidCallback onTap;
  const BestScoreBtn({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MenuBtnBase(
      onTap: onTap,
      children: [
        Trophy(rank: 1),
        ScoreText(),
      ],
    );
  }

  Widget ScoreText() {
    return Padding(
      padding: EdgeInsets.only(left: Constants.ui.paddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Best',
            style: TextStyle(
              color: Constants.ui.colors.mainText,
              fontSize: Constants.ui.fonts.sizeXxs,
            ),
          ),
          ScoreNumber(),
        ],
      ),
    );
  }

  Widget ScoreNumber() {
    return BlocBuilder<GameCubit, GameState>(builder: (context, state) {
      final record = state.currentLeaderboard?.ownerRecord;
      return Text(
        record?.score.toString() ?? '-',
        style: TextStyle(
          color: Constants.ui.colors.secondaryText,
          fontSize: Constants.ui.fonts.sizeSmall,
        ),
      );
    });
  }
}
