import 'package:realm/realm.dart';

part 'user.realm.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late String id;
  
  late String name;
  String? avatar;
  String? bio;
  String? title; // 头衔
  String? gender;
  String? location;
  int following = 0;
  int followers = 0;
  int friends = 0;
  int postsCount = 0;
  int coins = 1000; // 金币余额，默认1000
  bool isOnline = false;
  DateTime? createdAt;
  DateTime? updatedAt;
}
