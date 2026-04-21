import 'package:realm/realm.dart';

part 'chat_room.realm.dart';

@RealmModel()
class _ChatRoom {
  @PrimaryKey()
  late String id; // Format: room_{roomName}
  
  late String name; // Room name
  String? description; // Room description
  int membersCount = 0; // Number of members
  bool isHot = false; // Whether the room is hot/trending
  String? avatar; // Room avatar image path
  late DateTime createdAt;
  late DateTime updatedAt;
}
