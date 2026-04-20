import 'package:realm/realm.dart';

part 'settings.realm.dart';

@RealmModel()
class _Settings {
  @PrimaryKey()
  late String id; // 'app_settings'
  
  bool notifications = true;
  bool darkMode = false;
  String language = 'English';
  DateTime? updatedAt;
}
