import 'package:flappy_dash/presentation/dialogs/leaderboard_dialog.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future<void> showLeaderboard(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return LeaderBoardDialog();
      },
    );
  }
}
