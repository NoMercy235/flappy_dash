import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';

class NicknameDialog extends StatelessWidget {
  const NicknameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(Constants.ui.paddingSmall),
        decoration: _getContainerBoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your Nickname',
              style: TextStyle(
                color: Constants.ui.colors.secondaryText,
                fontSize: Constants.ui.fonts.sizeSmall,
              ),
            ),
            SizedBox(height: Constants.ui.sizes.spacingNormal),
            NicknameInput(),
            SizedBox(height: Constants.ui.sizes.spacingSmall),
            SizedBox(
              width: Constants.ui.sizes.nicknameSaveBtnWidth,
              child: FilledButton.tonal(
                onPressed: () {},
                child: const Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NicknameInput() {
    return TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        hintText: 'Nickname',
        hintStyle: TextStyle(
          color: Constants.ui.colors.whiteText,
        ),
        helperStyle: TextStyle(
          color: Constants.ui.colors.whiteText,
        ),
        labelStyle: TextStyle(
          color: Constants.ui.colors.whiteText,
        ),
      ),
      style: TextStyle(
        color: Constants.ui.colors.whiteText,
      ),
      maxLength: 12,
    );
  }

  BoxDecoration _getContainerBoxDecoration() {
    return BoxDecoration(
      color: Constants.ui.colors.dialogBgColor, // or white?
      border: Border.all(
        color: Colors.black,
        width: Constants.ui.sizes.shadowWidth,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(Constants.ui.boxBorderRadius),
      ),
      boxShadow: [Constants.ui.leaderBoardBoxShadow],
    );
  }
}
