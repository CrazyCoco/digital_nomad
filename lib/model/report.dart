import 'package:realm/realm.dart';

part 'report.realm.dart';

@RealmModel()
class _Report {
  @PrimaryKey()
  late String id;
  
  late String reporterId; // The user who reports
  late String reporterName;
  late String reportedUserId; // The user being reported
  late String reportedUserName;
  late String reason; // Report reason
  String? description; // Additional description
  late DateTime reportedAt;
  bool isResolved = false;
}
