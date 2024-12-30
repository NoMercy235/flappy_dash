import 'package:flappy_dash/utils/constants.dart';
import 'package:nakama/nakama.dart';

class NakamaDataSource {
  final client = getNakamaClient(
    host: Constants.user.host,
    ssl: false,
    serverKey: Constants.user.serverKey,
    grpcPort: 7349,
    httpPort: 7350,
  );

  late Session _currentSession;

  Future<Session> initSession(String deviceId) async {
    _currentSession = await client.authenticateDevice(
      deviceId: deviceId,
      username: Constants.user.username,
    );

    print('Session is $_currentSession');

    return _currentSession;
  }

  Future<LeaderboardRecordList> getLeaderboard(
    String leaderboardName,
  ) async {
    return await client.listLeaderboardRecords(
      session: _currentSession,
      leaderboardName: leaderboardName,
    );
  }

  Future<LeaderboardRecord> submitScore(
      String leaderboardName, int score) async {
    return client.writeLeaderboardRecord(
      session: _currentSession,
      leaderboardName: leaderboardName,
      score: score,
    );
  }
}
