import 'dart:async';

import 'package:flappy_dash/data/local/device_data_source.dart';
import 'package:flappy_dash/data/remote/nakama_data_source.dart';
import 'package:flappy_dash/domain/entities/leaderboard_entity.dart';
import 'package:flappy_dash/utils/constants.dart';
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

  Future<LeaderboardEntity> getLeaderboard(String leaderboardName) async {
    await _initializationCompleter.future;
    final recordList =
        await _nakamaDataSource.getLeaderboard(Constants.user.leaderboardName);
    final ids =
        recordList.records?.map((record) => record.ownerId!).toList() ?? [];
    final users = await _nakamaDataSource.getUsers(ids);
    final usersMap = Map.fromEntries(
      users.map((user) => MapEntry(user.id, user)),
    );

    final account = await _nakamaDataSource.getAccount();
    return LeaderboardEntity(
      recordList: recordList,
      userProfiles: usersMap,
      currentUserId: account.user.id,
    );
  }

  Future<LeaderboardRecord> submitScore(
    String leaderboardName,
    int score,
  ) async {
    await _initializationCompleter.future;
    return _nakamaDataSource.submitScore(leaderboardName, score);
  }

  changeDisplayName(String displayName) async {
    await _nakamaDataSource.changeDisplayName(displayName);
  }
}
