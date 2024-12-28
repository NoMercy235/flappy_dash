import 'package:flappy_dash/presentation/widgets/common/trophy.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LeaderBoardDialog extends StatelessWidget {
  const LeaderBoardDialog({super.key});

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
              height: 400,
              child: ListView.separated(
                itemBuilder: (context, index) => LeaderBoardRow(
                  rank: index + 1,
                  name: "Player ${index + 1}",
                  score: 100 * (20 - index),
                  isMine: index == 0,
                ),
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.white30,
                ),
                itemCount: 20,
              ),
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
  final int rank;
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
    return RowWrapper(
      child: Container(
        color: isMine ? Colors.white10 : Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Constants.ui.paddingSmall,
          vertical: Constants.ui.paddingXxs,
        ),
        child: Row(
          children: [
            rank <= 3 ? Trophy(rank: rank) : NormalScore(),
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

  Widget RowWrapper({required Widget child}) {
    return isMine
        ? Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
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
