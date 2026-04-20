import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class ProfileLogic extends GetxController {
  int selectedTab = 4;
  int contentTab = 0;
  
  // 视频列表
  final List<Map<String, dynamic>> videos = [
    {
      'title': 'Morning Coffee Routine',
      'thumbnail': 'images/175948fe83a531afbaf9a1bada957c27.jpg',
      'videoPath': 'images/100cbbc25bf271dc459d54e00fc218e9_720w.mp4',
      'duration': '2:34',
      'views': '1.2K',
      'time': '2 hours ago',
    },
    {
      'title': 'Beach Workspace Setup',
      'thumbnail': 'images/17faa625fce16f5d297a2e29dd15f716.jpg',
      'videoPath': 'images/132d3ac74640afb9545dc9e51ce8e9df.mp4',
      'duration': '3:15',
      'views': '856',
      'time': '5 hours ago',
    },
    {
      'title': 'Mountain View Office',
      'thumbnail': 'images/34a543da13c67f1fb1d6df299533f332.jpg',
      'videoPath': 'images/1a6954309c550d60b48b9bd001b0f370_720w.mp4',
      'duration': '1:48',
      'views': '2.3K',
      'time': '1 day ago',
    },
    {
      'title': 'Cafe Hopping in Bali',
      'thumbnail': 'images/3d9b5922a426a5f4afa12fb082489111.jpg',
      'videoPath': 'images/21c7b75472e945ffb863608cdef26353_t4.mp4',
      'duration': '4:22',
      'views': '3.1K',
      'time': '2 days ago',
    },
    {
      'title': 'Digital Nomad Tips',
      'thumbnail': 'images/40a805d3d08ff56df9c03c35d55e5191.jpg',
      'videoPath': 'images/2fb94a98f92223b765c6adf89a701950.mp4',
      'duration': '5:10',
      'views': '4.5K',
      'time': '3 days ago',
    },
    {
      'title': 'Sunset Work Session',
      'thumbnail': 'images/6a92315ff42af7de93e441d5dc581ea5.jpg',
      'videoPath': 'images/3e024ae4241ef369444b673969845350_t1.mp4',
      'duration': '2:56',
      'views': '1.8K',
      'time': '4 days ago',
    },
  ];
  
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
  
  void onVideoTap(int index) {
    final video = videos[index];
    NavigationUtil.toVideoPlayer(videoPath: video['videoPath']);
  }
}
