import 'package:flappy_dash/domain/extensions/user.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NicknameDialog extends StatefulWidget {
  const NicknameDialog({super.key});

  @override
  State<NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<NicknameDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    final name =
        context.read<GameCubit>().state.currentUserAccount?.user.showingName;
    _textEditingController = TextEditingController(text: name);
  }

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
                onPressed: () {
                  Navigator.of(context).pop(_textEditingController.text);
                },
                child: const Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget NicknameInput() {
    return TextField(
      controller: _textEditingController,
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
      maxLength: Constants.user.maxDisplayNameLength,
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
