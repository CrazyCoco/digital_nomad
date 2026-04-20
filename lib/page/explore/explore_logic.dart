import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';
import '../home/home_logic.dart';

class ExploreLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  // Tab controller
  int selectedTab = 0;
  
  // Popular/Following tab
  int contentTab = 0;
  
  // Hot topics - 热门话题
  final List<Map<String, dynamic>> hotTopics = [
    {
      'title': '#Nomad Life Stories & Experiences',
      'views': '12.7K',
      'color': const Color(0xFFB3E5FC),
      'image': 'images/8952cc30813886ec84178206d8877d23.jpg',
    },
    {
      'title': '#Gear Talk Essentials',
      'views': '8.5K',
      'color': const Color(0xFFFFCCBC),
      'image': 'images/948f9b32fa7f2957bc82ec3100b057aa.jpg',
    },
    {
      'title': '#Workspace Hacks & Setup Ideas',
      'views': '15.2K',
      'color': const Color(0xFFDCEDC8),
      'image': 'images/afc548276bf301d627730fb09e06be7f.jpg',
    },
    {
      'title': '#Travel Tips Guides',
      'views': '20.1K',
      'color': const Color(0xFFE1BEE7),
      'image': 'images/094de2a3d0f251804bbdf971c36c97ad.jpg',
    },
    {
      'title': '#Remote Work Best Practices',
      'views': '9.8K',
      'color': const Color(0xFFFFF9C4),
      'image': 'images/16dcb0bf7d0f122690c0b0e1916494d4.jpg',
    },
  ];
  
  // Posts loaded from Realm
  List<Map<String, dynamic>> posts = [];
  
  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }
  
  /// Load posts from Realm
  void loadPosts() {
    final allPosts = _realmService.getAllPosts();
    
    posts = allPosts.map((post) => {
      'id': post.id,
      'user': post.userName,
      'userId': post.userId,
      'time': _formatTime(post.createdAt),
      'content': post.description ?? 'No description',
      'views': '${(post.likes * 10 + post.comments * 5)}',
      'likes': post.likes,
      'liked': post.isLiked,
      'following': false,
      'avatar': post.userAvatar ?? 'images/head_1.jpg',
      'images': [post.image ?? ''],
      'category': post.category,
    }).toList();
    
    update();
  }
  
  /// Format DateTime to readable string
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return 'Just now';
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
  
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
    if (postIndex >= 0 && postIndex < posts.length) {
      final box = GetStorage();
      final currentUserId = box.read('user_id') as String?;
      final targetUserId = posts[postIndex]['userId'] as String?;
      
      if (currentUserId != null && targetUserId != null) {
        final isCurrentlyFollowing = posts[postIndex]['following'];
        
        if (isCurrentlyFollowing) {
          _realmService.unfollowUser(currentUserId, targetUserId);
        } else {
          _realmService.followUser(currentUserId, targetUserId);
        }
        
        posts[postIndex]['following'] = !isCurrentlyFollowing;
        update();
        
        // Notify HomeLogic to refresh suggested users
        try {
          final homeLogic = Get.find<HomeLogic>();
          homeLogic.refreshSuggestedUsers();
        } catch (e) {
          // HomeLogic might not be initialized yet
          print('HomeLogic not found: $e');
        }
      }
    }
  }
  
  /// Toggle like
  void toggleLike(int postIndex) {
    if (postIndex >= 0 && postIndex < posts.length) {
      final post = posts[postIndex];
      final postId = post['id'] as String?;
      
      if (postId != null) {
        // Update in Realm
        _realmService.toggleLike(postId);
        
        // Update local state
        post['liked'] = !post['liked'];
        if (post['liked']) {
          post['likes']++;
        } else {
          post['likes']--;
        }
        update();
      }
    }
  }
  
  void onTopicTap() {
    NavigationUtil.toTopic();
  }
}
