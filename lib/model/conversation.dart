import 'package:realm/realm.dart';

part 'conversation.realm.dart';

@RealmModel()
class _Conversation {
  @PrimaryKey()
  late String id;
  
  late String userId;
  late String userName;
  String? userAvatar;
  String? lastMessage;
  DateTime? lastMessageTime;
  int unreadCount = 0;
  bool isOnline = false;
  DateTime? createdAt;
  DateTime? updatedAt;
}
