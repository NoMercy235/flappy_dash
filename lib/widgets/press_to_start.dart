import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter/material.dart';

class PressToStart extends StatelessWidget {
  const PressToStart({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.center,
        child: const Text(
          'Tap to start',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: Constants.fontSizeSmall,
          ),
        ),
      ),
    );
  }
}
