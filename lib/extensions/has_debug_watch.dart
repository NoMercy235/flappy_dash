import 'package:flame/components.dart';
import 'package:flappy_dash/utils/constants.dart';

mixin HasDebugWatch on Component {
  @override
  void update(double dt) {
    debugMode = Constants.isDebugMode;
    super.update(dt);
  }
}
