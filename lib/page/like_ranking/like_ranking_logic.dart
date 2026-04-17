import 'package:get/get.dart';

class LikeRankingLogic extends GetxController {
  List<Map<String, dynamic>> rankings = [
    {'rank': 1, 'name': 'Alice Johnson', 'likes': 15234, 'avatar': ''},
    {'rank': 2, 'name': 'Bob Smith', 'likes': 12890, 'avatar': ''},
    {'rank': 3, 'name': 'Carol White', 'likes': 9876, 'avatar': ''},
    {'rank': 4, 'name': 'David Brown', 'likes': 7654, 'avatar': ''},
    {'rank': 5, 'name': 'Emma Davis', 'likes': 6543, 'avatar': ''},
  ];
  
  void onBack() => Get.back();
}
