import 'package:flappy_dash/utils/constants.dart';
import 'package:nakama/nakama.dart';

class NakamaDataSource {
  final client = getNakamaClient(
    host: Constants.user.host,
    ssl: !Constants.isDebugMode,
    serverKey: Constants.user.serverKey,
    grpcPort: Constants.isDebugMode ? 7349 : 7359,
    httpPort: Constants.isDebugMode ? 7350 : 7360,
  );

  late Session _currentSession;
  late String _deviceId;

  Future<Session> initSession(String deviceId) async {
    _deviceId = deviceId;
    _currentSession = await client.authenticateDevice(
      deviceId: deviceId,
    );

    print('Session is $_currentSession');

    return _currentSession;
  }

  Future<Account> getAccount() => client.getAccount(_currentSession);

  Future<List<User>> getUsers(List<String> userIds) => client.getUsers(
        session: _currentSession,
        ids: userIds,
      );

  Future<LeaderboardRecordList> getLeaderboard(
    String leaderboardName,
  ) async {
    await _ensureSession();
    return await client.listLeaderboardRecords(
      session: _currentSession,
      leaderboardName: leaderboardName,
    );
  }

  Future<LeaderboardRecord> submitScore(
      String leaderboardName, int score) async {
    await _ensureSession();
    return client.writeLeaderboardRecord(
      session: _currentSession,
      leaderboardName: leaderboardName,
      score: score,
    );
  }

  Future<void> changeDisplayName(String displayName) async {
    await _ensureSession();
    return client.updateAccount(
      session: _currentSession,
      displayName: displayName,
    );
  }

  Future<LeaderboardRecordList> listLeaderboardRecordsAroundOwner(
    String leaderboardName,
  ) async {
    await _ensureSession();
    return client.listLeaderboardRecordsAroundOwner(
      session: _currentSession,
      ownerId: _currentSession.userId,
      leaderboardName: leaderboardName,
    );
  }

  Future<void> _ensureSession() async {
    if (_currentSession == null || _currentSession!.isExpired) {
      print("Refreshing the session");
      _currentSession = await client.sessionRefresh(
        session: _currentSession,
      );
    }
  }
}
