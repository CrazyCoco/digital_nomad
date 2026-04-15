import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreLogic extends GetxController {
  // Tab controller
  int selectedTab = 1;
  
  // Popular/Following tab
  int contentTab = 0;
  
  // Hot topics
  final List<Map<String, dynamic>> hotTopics = [
    {
      'title': '#Nomad Life Stories & Experiences',
      'views': '12739',
      'color': const Color(0xFFB3E5FC),
    },
    {
      'title': '#Gear Talk Essentials',
      'views': '12739',
      'color': const Color(0xFFFFCCBC),
    },
    {
      'title': '#Workspace Hacks & Setup Ideas',
      'views': '12739',
      'color': const Color(0xFFDCEDC8),
    },
    {
      'title': '#Travel Tips Guides',
      'views': '12739',
      'color': const Color(0xFFE1BEE7),
    },
  ];
  
  // Posts
  final List<Map<String, dynamic>> posts = [
    {
      'user': 'Danny',
      'time': '11:00AM',
      'content': 'How to set boundaries with a clingy partner without hurting them?How to set boundaries with a clingy partner without hurting them...',
      'views': '12739',
      'likes': 24,
      'liked': true,
      'following': false,
    },
    {
      'user': 'Danny',
      'time': '11:00AM',
      'content': 'How to set boundaries with a clingy partner without hurting them?How to set boundaries with a clingy partner without hurting them...',
      'views': '12739',
      'likes': 24,
      'liked': false,
      'following': true,
    },
  ];
  
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  
  /// Select bottom tab
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  /// Select content tab
  void selectContentTab(int index) {
    contentTab = index;
    update();
  }
  
  /// Toggle follow
  void toggleFollow(int postIndex) {
    posts[postIndex]['following'] = !posts[postIndex]['following'];
    update();
  }
  
  /// Toggle like
  void toggleLike(int postIndex) {
    posts[postIndex]['liked'] = !posts[postIndex]['liked'];
    if (posts[postIndex]['liked']) {
      posts[postIndex]['likes']++;
    } else {
      posts[postIndex]['likes']--;
    }
    update();
  }
}
