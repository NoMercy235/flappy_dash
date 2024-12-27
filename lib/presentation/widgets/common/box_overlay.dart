import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';

class BoxOverlay extends StatelessWidget {
  final Widget child;
  const BoxOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.ui.colors.boxBgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Constants.ui.boxBorderRadius),
        ),
      ),
      padding: Constants.ui.sizes.boxOverlayPadding,
      child: child,
    );
  }
}
