import 'package:realm/realm.dart';

part 'chat_message.realm.dart';

@RealmModel()
class _ChatMessage {
  @PrimaryKey()
  late String id;
  
  late String conversationId;
  late String senderId;
  late String senderName;
  String? senderAvatar;
  late String content;
  String? imageUrl;
  String? videoUrl;
  int messageType = 0; // 0: text, 1: image, 2: video
  bool isRead = false;
  DateTime? createdAt;
}
