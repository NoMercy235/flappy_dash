import 'package:flappy_dash/data/local/device_data_source.dart';
import 'package:flappy_dash/data/remote/nakama_data_source.dart';
import 'package:nakama/nakama.dart';

class GameRepository {
  final DeviceDataSource _deviceDataSource;
  final NakamaDataSource _nakamaDataSource;
  GameRepository(this._deviceDataSource, this._nakamaDataSource);

  Future<Session> initSession() async {
    final deviceId = await _deviceDataSource.getDeviceId();
    final session = await _nakamaDataSource.initSession(deviceId);
    return session;
  }

  Future<LeaderboardRecordList> getLeaderboard(String leaderboardName) =>
      _nakamaDataSource.getLeaderboard(leaderboardName);

  Future<LeaderboardRecord> submitScore(String leaderboardName, int score) =>
      _nakamaDataSource.submitScore(leaderboardName, score);
}
