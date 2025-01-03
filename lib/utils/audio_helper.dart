import 'package:flappy_dash/utils/constants.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class AudioHelper {
  late SoLoud _soLoud;
  late AudioSource _bgSource;
  late AudioSource _scoreSource;

  SoundHandle? _bgSoundHandle;

  Future<void> initialize() async {
    _soLoud = SoLoud.instance;
    await _soLoud.init();
    _bgSource = await _soLoud.loadAsset('assets/audio/background.mp3');
    _scoreSource = await _soLoud.loadAsset('assets/audio/score.mp3');
  }

  void playBgAudio() async {
    if (_bgSoundHandle != null) {
      print("Background music already playing! Should not see this message");
      return;
    }

    _bgSoundHandle = await _soLoud.play(_bgSource, looping: true);
    _soLoud.setProtectVoice(_bgSoundHandle!, true);

    // TODO: remove this at the end
    _soLoud.setVolume(_bgSoundHandle!, 0.1);
  }

  void resumeBgAudio() {
    if (_bgSoundHandle == null) return;
    _soLoud.fadeVolume(
      _bgSoundHandle!,
      Constants.gameOverMenuSoundLevel,
      Constants.gameOverMenuSoundLevelFadeDuration,
    );
  }

  void stopBgAudio() {
    if (_bgSoundHandle == null) return;
    _soLoud.fadeVolume(
      _bgSoundHandle!,
      Constants.gameOverMenuSoundLevel,
      Constants.gameOverMenuSoundLevelFadeDuration,
    );
  }

  void playScoreAudio() async {
    await _soLoud.play(_scoreSource);
  }
}
