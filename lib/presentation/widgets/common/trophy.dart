import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Trophy extends StatelessWidget {
  final int rank;
  const Trophy({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor) = _getColor();

    return SizedBox(
      height: Constants.ui.sizes.iconHeight,
      width: Constants.ui.sizes.iconWidth,
      child: Stack(
        children: [
          SvgPicture.asset(
            Constants.files.icTrophy,
            height: Constants.ui.sizes.iconHeight,
            colorFilter: ColorFilter.mode(
              bgColor,
              BlendMode.srcIn,
            ),
          ),
          Align(
            alignment: Constants.ui.sizes.trophyNrAlignment,
            child: Text(
              rank.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: Constants.ui.fonts.sizeXxs,
              ),
            ),
          ),
        ],
      ),
    );
  }

  (Color, Color) _getColor() {
    final colors = Constants.ui.colors;
    switch (rank) {
      case 1:
        return (colors.trophyGoldBgColor, colors.trophyGoldTextColor);
      case 2:
        return (colors.trophySilverBgColor, colors.trophySilverTextColor);
      case 3:
        return (colors.trophyBronzeBgColor, colors.trophyBronzeTextColor);
      default:
        throw ('Trophy color does not exist');
    }
  }
}
