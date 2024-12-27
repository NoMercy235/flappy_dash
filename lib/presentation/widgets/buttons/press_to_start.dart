import 'package:flappy_dash/presentation/widgets/common/box_overlay.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PressToStart extends StatelessWidget {
  const PressToStart({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.center,
        child: BoxOverlay(
          child: Text(
            'Tap to start',
            style: TextStyle(
              color: Constants.ui.colors.mainText,
              fontWeight: FontWeight.bold,
              fontSize: Constants.ui.fonts.sizeSmall,
              letterSpacing: Constants.ui.fonts.letterSpacing,
            ),
          ),
        ),
      )
          .animate(
            onPlay: (ctrl) => ctrl.repeat(reverse: true),
          )
          .scale(
            begin: Offset(Constants.ui.animations.scaleAnimationBegin,
                Constants.ui.animations.scaleAnimationBegin),
            end: Offset(Constants.ui.animations.scaleAnimationEnd,
                Constants.ui.animations.scaleAnimationEnd),
            duration: Constants.ui.animations.scaleAnimationDuration,
          ),
    );
  }
}
