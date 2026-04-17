import 'package:get/get.dart';

import '../../routes/app_routes.dart';

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
  
  void onEditProfile() {
    NavigationUtil.toEditProfile();
  }
  
  void onSettings() {
    NavigationUtil.toSettings();
  }
  
  void onFollowers() {
    NavigationUtil.toFollowList(initialTab: 1);
  }
  
  void onFollowing() {
    NavigationUtil.toFollowList(initialTab: 0);
  }
  
  void onFriends() {
    NavigationUtil.toFollowList(initialTab: 2);
  }
  
  void onFriendRequests() {
    NavigationUtil.toFriendRequest();
  }
  
  void onBlacklist() {
    NavigationUtil.toBlacklist();
  }
  
  void onRecharge() {
    NavigationUtil.toRecharge();
  }
}
