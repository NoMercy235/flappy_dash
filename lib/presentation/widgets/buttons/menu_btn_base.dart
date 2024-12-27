import 'package:flappy_dash/presentation/widgets/common/box_overlay.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';

class MenuBtnBase extends StatelessWidget {
  final List<Widget> children;
  const MenuBtnBase({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.ui.paddingSmall,
        vertical: Constants.ui.paddingXxs,
      ),
      child: BoxOverlay(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
