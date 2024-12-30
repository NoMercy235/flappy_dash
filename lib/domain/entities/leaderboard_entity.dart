import 'package:equatable/equatable.dart';
import 'package:flappy_dash/domain/extensions/user.dart';
import 'package:nakama/nakama.dart';

class LeaderboardEntity with EquatableMixin {
  LeaderboardRecord? get ownerRecord => _getOwnerRecord();

  int get length => _recordList.records!.length;

  final LeaderboardRecordList _recordList;
  final Map<String, User> _userProfiles;
  final String _currentUserId;

  (LeaderboardRecord record, String name) operator [](int index) {
    final record = _recordList.records![index];
    final user = _userProfiles[record.ownerId!]!;
    return (record, user.showingName);
  }

  LeaderboardEntity({
    required LeaderboardRecordList recordList,
    required Map<String, User> userProfiles,
    required String currentUserId,
  })  : _userProfiles = userProfiles,
        _recordList = recordList,
        _currentUserId = currentUserId,
        assert(recordList.records?.length == userProfiles.length);

  @override
  List<Object?> get props => [
        _recordList,
        _userProfiles,
      ];

  LeaderboardRecord? _getOwnerRecord() {
    if (_recordList.records == null) {
      return null;
    }
    for (final record in _recordList.records!) {
      if (record.ownerId == _currentUserId) {
        return record;
      }
    }
    return null;
  }
}
