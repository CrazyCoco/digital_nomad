import 'package:realm/realm.dart';

part 'blocklist.realm.dart';

@RealmModel()
class _Blocklist {
  @PrimaryKey()
  late String id; // Format: {blockerId}_{blockedUserId}
  
  late String blockerId; // The user who blocks
  late String blockedUserId; // The user being blocked
  late DateTime blockedAt;
}
