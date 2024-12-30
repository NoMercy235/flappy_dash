import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/widgets/buttons/menu_btn_base.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileBtn extends StatelessWidget {
  const ProfileBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuBtnBase(
      onTap: () {},
      children: [
        SvgPicture.asset(
          Constants.files.icProfile,
          height: Constants.ui.sizes.iconHeight,
        ),
        Padding(
          padding: EdgeInsets.only(left: Constants.ui.paddingSmall),
          child: BlocBuilder<GameCubit, GameState>(builder: (context, state) {
            return Text(
              state.currentUserAccount?.user.username ?? 'My Profile',
              style: TextStyle(
                color: Constants.ui.colors.mainText,
                fontSize: Constants.ui.fonts.sizeSmall,
              ),
            );
          }),
        ),
      ],
    );
  }
}
