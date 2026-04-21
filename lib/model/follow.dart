import 'package:realm/realm.dart';

part 'follow.realm.dart';

@RealmModel()
class _Follow {
  @PrimaryKey()
  late String id; // followerId_followingId
  
  late String followerId; // 关注者ID
  late String followingId; // 被关注者ID
  late DateTime createdAt;
}
