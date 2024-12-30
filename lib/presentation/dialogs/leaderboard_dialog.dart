import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/dialogs/app_dialog.dart';
import 'package:flappy_dash/presentation/widgets/common/trophy.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LeaderBoardDialog extends StatefulWidget {
  const LeaderBoardDialog({super.key});

  @override
  State<LeaderBoardDialog> createState() => _LeaderBoardDialogState();
}

class _LeaderBoardDialogState extends State<LeaderBoardDialog> {
  @override
  void initState() {
    context.read<GameCubit>().refreshLeaderboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        width: Constants.ui.sizes.dialogWidth,
        decoration: BoxDecoration(
          color: Constants.ui.colors.dialogBgColor,
          border: Border.all(
            color: Colors.black,
            width: Constants.ui.sizes.shadowWidth,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Constants.ui.boxBorderRadius),
          ),
          boxShadow: [Constants.ui.leaderBoardBoxShadow],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(onPressed: () => Navigator.of(context).pop()),
            SizedBox(
              height: Constants.ui.sizes.leaderboardViewHeight,
              child:
                  BlocBuilder<GameCubit, GameState>(builder: (context, state) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final (item, name) = state.currentLeaderboard![index];
                    return LeaderBoardRow(
                      rank: int.parse(item.rank ?? '9999'),
                      name: name,
                      score: int.parse(item.score ?? '0'),
                      isMine: item.ownerId == state.currentUserAccount?.user.id,
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: Constants.ui.sizes.leaderboardRowSeparatorHeight,
                    color: Constants.ui.colors.leaderboardRowSeparator,
                  ),
                  itemCount: state.currentLeaderboard?.length ?? 0,
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget Header({required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: Constants.ui.sizes.iconWidth),
        Text(
          "Leaderboard",
          style: TextStyle(
            color: Constants.ui.colors.secondaryText,
            fontSize: Constants.ui.fonts.sizeXxs,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            Constants.files.icClose,
            width: Constants.ui.sizes.iconWidth,
            height: Constants.ui.sizes.iconHeight,
          ),
        ),
      ],
    );
  }
}

class LeaderBoardRow extends StatelessWidget {
  final int? rank;
  final String name;
  final int score;
  final bool isMine;
  const LeaderBoardRow({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedRank = rank ?? 1;

    return RowWrapper(
      context: context,
      child: Container(
        color: isMine ? Colors.white10 : Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Constants.ui.paddingSmall,
          vertical: Constants.ui.paddingXxs,
        ),
        child: Row(
          children: [
            calculatedRank <= 3 ? Trophy(rank: calculatedRank) : NormalScore(),
            Padding(
              padding: EdgeInsets.only(left: Constants.ui.paddingXxs),
              child: Text(
                name,
                style: TextStyle(
                  color: isMine
                      ? Constants.ui.colors.whiteTextHighlighted
                      : Constants.ui.colors.whiteText,
                  fontSize: Constants.ui.fonts.sizeSmall,
                ),
              ),
            ),
            if (isMine)
              Padding(
                padding: EdgeInsets.only(left: Constants.ui.paddingXxs),
                child: Text(
                  '(edit)',
                  style: TextStyle(color: Constants.ui.colors.mainText),
                ),
              ),
            Expanded(child: Container()),
            Text(
              score.toString(),
              style: TextStyle(
                color: Constants.ui.colors.secondaryText,
                fontSize: Constants.ui.fonts.sizeSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget RowWrapper({required BuildContext context, required Widget child}) {
    return isMine
        ? Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => AppDialog.showNicknamePicker(context),
              child: child,
            ),
          )
        : Container(child: child);
  }

  Widget NormalScore() {
    return Container(
      width: Constants.ui.sizes.iconWidth,
      height: Constants.ui.sizes.iconHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Constants.ui.colors.mainText,
        ),
      ),
      child: Center(
        child: Text(
          rank.toString(),
          style: TextStyle(
              color: Constants.ui.colors.mainText,
              fontSize: Constants.ui.fonts.sizeXxs),
        ),
      ),
    );
  }
}
