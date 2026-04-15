import 'package:get/get.dart';

class ProfileLogic extends GetxController {
  int selectedTab = 4;
  int contentTab = 0;
  
  final List<Map<String, dynamic>> posts = [
    {
      'user': 'Danny',
      'time': '11:00AM',
      'content': 'How to set boundaries with a clingy partner without hurting them?How to set boundaries with a clingy partner without hurting them...',
      'views': '12739',
      'likes': 24,
    },
  ];
  
  @override
  void onReady() { super.onReady(); }
  @override
  void onClose() { super.onClose(); }
  
  void selectTab(int index) { 
    selectedTab = index;
    update();
  }
  
  void selectContentTab(int index) { 
    contentTab = index;
    update();
  }
}
