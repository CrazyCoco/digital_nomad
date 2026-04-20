import 'package:realm/realm.dart';

part 'comment.realm.dart';

@RealmModel()
class _Comment {
  @PrimaryKey()
  late String id;
  
  late String postId;
  late String userId;
  late String userName;
  String? userAvatar;
  late String content;
  int likes = 0;
  bool isLiked = false;
  DateTime? createdAt;
}
