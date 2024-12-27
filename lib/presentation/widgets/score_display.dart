import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  final int score;
  const ScoreDisplay({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: Constants.ui.paddingNormal),
          child: Text(
            "$score",
            style: TextStyle(
                color: Constants.ui.colors.secondaryText,
                fontSize: Constants.ui.fonts.sizeNormal),
          ),
        ),
      ),
    );
  }
}
