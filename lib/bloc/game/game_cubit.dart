import 'package:equatable/equatable.dart';
import 'package:flappy_dash/utils/audio_helper.dart';
import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakama/nakama.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(
    this._audioHelper,
  ) : super(GameState()) {
    _initializeNakama();
  }

  final AudioHelper _audioHelper;

  void startPlaying() {
    emit(state.copyWith(
      newPlayingState: PlayingState.playing,
      newScore: 0,
    ));
  }

  void reset() {
    _audioHelper.resumeBgAudio();
    emit(state.copyWith(
      newPlayingState: PlayingState.none,
      newScore: 0,
    ));
  }

  void increaseScore() {
    _audioHelper.playScoreAudio();
    emit(state.copyWith(newScore: state.currentScore + 1));
  }

  void gameOver() {
    _audioHelper.stopBgAudio();
    emit(state.copyWith(newPlayingState: PlayingState.gameOver));
  }

  void _initializeNakama() async {
    final client = getNakamaClient(
      host: Constants.user.host,
      ssl: false,
      serverKey: Constants.user.serverKey,
      grpcPort: 7349,
      httpPort: 7350,
    );

    final session = await client.authenticateDevice(
      deviceId: Constants.user.deviceId,
      username: Constants.user.username,
    );

    final group = await client.createGroup(
      session: session,
      name: Constants.user.groupName,
    );

    print('group is: ${group.name}');
  }
}
