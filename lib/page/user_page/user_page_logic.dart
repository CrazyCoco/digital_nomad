import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class UserPageLogic extends GetxController {
  // 用户信息
  String userName = 'John Doe';
  String userBio = 'Digital nomad | Travel enthusiast | Coffee lover';
  int followingCount = 256;
  int followersCount = 1024;
  int friendsCount = 128;
  int postsCount = 45;
  
  // Tab 选择
  int selectedTab = 0;
  final List<String> tabs = ['Posts', 'Likes'];
  
  // 关注状态
  bool isFollowing = false;
  
  // 动态列表
  List<Map<String, dynamic>> posts = [
    {
      'image': 'images/Group 1000009700@3x(9).png',
      'likes': 128,
      'comments': 24,
      'time': '2 hours ago',
      'liked': false,
    },
    {
      'image': 'images/Group 1000009700@3x(10).png',
      'likes': 256,
      'comments': 48,
      'time': '5 hours ago',
      'liked': true,
    },
    {
      'image': 'images/Group 1000009700@3x(11).png',
      'likes': 64,
      'comments': 12,
      'time': '1 day ago',
      'liked': false,
    },
  ];
  
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  void toggleFollow() {
    isFollowing = !isFollowing;
    if (isFollowing) {
      followersCount++;
    } else {
      followersCount--;
    }
    update();
  }
  
  void toggleLike(int index) {
    posts[index]['liked'] = !posts[index]['liked'];
    if (posts[index]['liked']) {
      posts[index]['likes']++;
    } else {
      posts[index]['likes']--;
    }
    update();
  }
  
  void onBack() {
    Get.back();
  }
  
  void onEditProfile() {
    // TODO: Navigate to edit profile
    print('Edit profile');
  }
  
  void onMessage() {
    NavigationUtil.toPrivateChat(
      userName: userName,
      userAvatar: '',
    );
  }
  
  void onMoreOptions() {
    // TODO: Show more options menu
    print('More options');
  }
}
