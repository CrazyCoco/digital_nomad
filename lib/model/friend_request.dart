import 'package:realm/realm.dart';

part 'friend_request.realm.dart';

@RealmModel()
class _FriendRequest {
  @PrimaryKey()
  late String id; // Format: requesterId_receiverId
  
  late String requesterId; // 请求者ID
  late String requesterName; // 请求者姓名
  String? requesterAvatar; // 请求者头像
  String? message; // 请求消息
  
  late String receiverId; // 接收者ID
  
  late DateTime createdAt; // 请求时间
  bool isRead = false; // 是否已读
}
