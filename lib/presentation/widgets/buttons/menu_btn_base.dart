import 'package:flappy_dash/presentation/widgets/common/box_overlay.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';

class MenuBtnBase extends StatelessWidget {
  final List<Widget> children;
  final bool withPadding;
  final VoidCallback onTap;
  const MenuBtnBase({
    super.key,
    required this.children,
    required this.onTap,
    this.withPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: withPadding
          ? EdgeInsets.symmetric(
              horizontal: Constants.ui.paddingSmall,
              vertical: Constants.ui.paddingXxs,
            )
          : EdgeInsets.all(0),
      child: Material(
        color: Colors.transparent, // Fix ripple effect on tap
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(Constants.ui.boxBorderRadius),
          ),
          onTap: onTap,
          child: BoxOverlay(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
