import 'package:realm/realm.dart';

part 'post.realm.dart';

@RealmModel()
class _Post {
  @PrimaryKey()
  late String id;
  
  late String userId;
  late String userName;
  String? userAvatar;
  String? description;
  String? image;
  String? videoPath;
  bool isVideo = false;
  int likes = 0;
  int comments = 0;
  int shares = 0;
  int views = 0; // 浏览量
  bool isLiked = false;
  String? category; // Colab, Cafe, Outdoor
  String? weather;
  DateTime? createdAt;
  DateTime? updatedAt;
}
