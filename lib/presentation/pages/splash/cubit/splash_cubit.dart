import 'package:equatable/equatable.dart';
import 'package:flappy_dash/domain/repositories/game_repository.dart';
import 'package:flappy_dash/utils/audio_helper.dart';
import 'package:flappy_dash/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GameRepository _gameRepository;
  SplashCubit(
    this._gameRepository,
  ) : super(const SplashState());

  static const _splashDuration = Duration(seconds: 2);

  void onPageOpen() async {
    try {
      final startTime = DateTime.now();
      await _initialize();
      final endTime = DateTime.now();
      final difference = endTime.difference(startTime);
      if (difference < _splashDuration) {
        await Future.delayed(_splashDuration - difference);
      }
      _openHomePage();
    } catch (e, stack) {
      print('error: $e, $stack');
    }
  }

  Future<void> _initialize() async {
    await _gameRepository.initSession();
    await getIt.get<AudioHelper>().initialize();
  }

  void _openHomePage() async {
    emit(state.copyWith(openHomePage: true));
    emit(state.copyWith(openHomePage: false));
  }
}
