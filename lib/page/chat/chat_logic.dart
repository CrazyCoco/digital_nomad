import 'package:get/get.dart';

class ChatLogic extends GetxController {
  int selectedTab = 2;
  
  final List<Map<String, dynamic>> chatRooms = [
    {'name': 'Cafe Nomads', 'hot': true},
    {'name': 'Cafe Nomads', 'hot': true},
    {'name': 'Cafe Nomads', 'hot': true},
    {'name': 'Cafe Nomads', 'hot': true},
    {'name': 'Cafe Nomads', 'hot': true},
    {'name': 'Cafe Nomads', 'hot': true},
  ];
  
  @override
  void onReady() { super.onReady(); }
  @override
  void onClose() { super.onClose(); }
  
  void selectTab(int index) { 
    selectedTab = index;
    update();
  }
}
