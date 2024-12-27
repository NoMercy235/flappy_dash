import 'package:flappy_dash/presentation/widgets/buttons/menu_btn_base.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BestScoreBtn extends StatelessWidget {
  const BestScoreBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuBtnBase(
      children: [
        SizedBox(
          height: Constants.ui.sizes.iconHeight,
          width: Constants.ui.sizes.iconWidth,
          child: Stack(
            children: [
              SvgPicture.asset(
                Constants.files.icTrophy,
                height: Constants.ui.sizes.iconHeight,
                colorFilter: ColorFilter.mode(
                  Constants.ui.colors.trophyGoldBgColor,
                  BlendMode.srcIn,
                ),
              ),
              Align(
                alignment: Constants.ui.sizes.trophyNrAlignment,
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Constants.ui.colors.trophyGoldTextColor,
                    fontSize: Constants.ui.fonts.sizeXxs,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
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
              Text(
                '122',
                style: TextStyle(
                  color: Constants.ui.colors.secondaryText,
                  fontSize: Constants.ui.fonts.sizeSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
