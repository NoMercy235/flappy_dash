import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_dash/utils/constants.dart';

mixin HasDebugWatch on Component {
  @override
  FutureOr<void> onLoad() {
    debugMode = Constants.isDebugMode;
    return super.onLoad();
  }
}
