import 'dart:async';

import 'package:flappy_dash/data/local/device_data_source.dart';
import 'package:flappy_dash/data/remote/nakama_data_source.dart';
import 'package:nakama/nakama.dart';

class GameRepository {
  final DeviceDataSource _deviceDataSource;
  final NakamaDataSource _nakamaDataSource;
  GameRepository(this._deviceDataSource, this._nakamaDataSource);

  final Completer<void> _initializationCompleter = Completer<void>();

  Future<Session> initSession() async {
    try {
      final deviceId = await _deviceDataSource.getDeviceId();
      final session = await _nakamaDataSource.initSession(deviceId);
      _initializationCompleter.complete();
      return session;
    } catch (err) {
      _initializationCompleter.completeError(err);
      rethrow;
    }
  }

  Future<Account> getCurrentUserAccount() async {
    await _initializationCompleter.future;
    return _nakamaDataSource.getAccount();
  }

  Future<LeaderboardRecordList> getLeaderboard(String leaderboardName) async {
    await _initializationCompleter.future;
    return _nakamaDataSource.getLeaderboard(leaderboardName);
  }

  Future<LeaderboardRecord> submitScore(
    String leaderboardName,
    int score,
  ) async {
    await _initializationCompleter.future;
    return _nakamaDataSource.submitScore(leaderboardName, score);
  }

  changeUsername(String username) async {
    await _nakamaDataSource.changeUsername(username);
  }
}
