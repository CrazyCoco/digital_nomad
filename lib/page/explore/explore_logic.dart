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
  
  // Hot topics - 热门话题 (从帖子数据动态生成)
  List<Map<String, dynamic>> hotTopics = [];
  
  // Posts loaded from Realm
  List<Map<String, dynamic>> posts = [];
  
  // Filtered posts for display
  List<Map<String, dynamic>> displayPosts = [];
  
  @override
  void onInit() {
    super.onInit();
    loadPosts();
    loadFollowingState();
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
      'following': false, // Will be updated in loadFollowingState
      'avatar': post.userAvatar ?? 'images/head_1.jpg',
      'images': post.image != null && post.image!.isNotEmpty ? [post.image] : [],
      'category': post.category,
    }).toList();
    
    // Load following state and then filter posts
    loadFollowingState();
    
    // 帖子加载完后更新热门话题
    loadHotTopics();
  }
  
  /// Load following state for all posts
  void loadFollowingState() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId != null) {
      // Get all users I'm following (returns List<User>)
      final followingUsers = _realmService.getFollowingUsers(currentUserId);
      final followingUserIds = followingUsers.map((user) => user.id).toSet();
      
      // Update following state for each post
      for (var post in posts) {
        final userId = post['userId'] as String?;
        if (userId != null) {
          post['following'] = followingUserIds.contains(userId);
        }
      }
    }
    
    // Update display posts based on current tab
    updateDisplayPosts();
    update();
  }
  
  /// Update display posts based on selected tab
  void updateDisplayPosts() {
    if (contentTab == 0) {
      // Popular tab: show all posts
      displayPosts = List.from(posts);
    } else {
      // Following tab: show only posts from followed users
      displayPosts = posts.where((post) => post['following'] == true).toList();
    }
  }
  
  /// Load hot topics from posts
  void loadHotTopics() {
    // 颜色主题池
    final colors = [
      const Color(0xFFB3E5FC),
      const Color(0xFFFFCCBC),
      const Color(0xFFDCEDC8),
      const Color(0xFFE1BEE7),
      const Color(0xFFFFF9C4),
      const Color(0xFFC5CAE9),
      const Color(0xFFB2DFDB),
      const Color(0xFFF8BBD0),
    ];
    
    final images = [
      'images/8952cc30813886ec84178206d8877d23.jpg',
      'images/948f9b32fa7f2957bc82ec3100b057aa.jpg',
      'images/afc548276bf301d627730fb09e06be7f.jpg',
      'images/094de2a3d0f251804bbdf971c36c97ad.jpg',
      'images/16dcb0bf7d0f122690c0b0e1916494d4.jpg',
      'images/c7f144b248e8c12c05b5b5e7e6f7e8f9.jpg',
      'images/cc6d29a7b8c9d0e1f2a3b4c5d6e7f8a9.jpg',
      'images/e9e17b6c7d8e9f0a1b2c3d4e5f6a7b8c.jpg',
    ];
    
    // 从帖子中提取话题标签
    Map<String, int> topicCount = {};
    
    for (final post in posts) {
      final content = post['content'] as String? ?? '';
      // 提取所有以 # 开头的标签
      final hashtagRegex = RegExp(r'#\w+(?:\s+\w+)*');
      final matches = hashtagRegex.allMatches(content);
      
      for (final match in matches) {
        final topic = match.group(0)!;
        topicCount[topic] = (topicCount[topic] ?? 0) + 1;
      }
    }
    
    // 如果没有话题，使用默认话题
    if (topicCount.isEmpty) {
      topicCount = {
        '#NomadLife': 12,
        '#RemoteWork': 10,
        '#TravelTips': 8,
        '#DigitalNomad': 15,
        '#CoworkingSpace': 6,
      };
    }
    
    // 按出现次数排序，取前8个
    final sortedTopics = topicCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    hotTopics = sortedTopics.take(8).map((entry) {
      final index = sortedTopics.indexOf(entry);
      final totalCount = entry.value;
      // 格式化浏览量
      String views;
      if (totalCount >= 1000) {
        views = '${(totalCount / 1000).toStringAsFixed(1)}K';
      } else {
        views = '$totalCount';
      }
      
      return {
        'title': entry.key,
        'views': views,
        'color': colors[index % colors.length],
        'image': images[index % images.length],
      };
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
    updateDisplayPosts();
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
  
  /// Navigate to user profile
  void onUserTap(String userName) {
    NavigationUtil.toUserPage(userName: userName);
  }
  
  /// Navigate to post detail
  void onPostTap(int index) {
    // Use displayPosts instead of posts
    if (index >= 0 && index < displayPosts.length) {
      final post = displayPosts[index];
      // Navigate to post detail with callback
      Get.toNamed(
        '/postDetail',
        arguments: post,
      )?.then((_) {
        // Refresh posts when returning from post detail
        loadPosts();
      });
    }
  }
  
  /// Play video
  void onPlayVideo(int index) {
    if (index >= 0 && index < posts.length) {
      final post = posts[index];
      if (post['isVideo'] == true && post['videoPath'] != null) {
        NavigationUtil.toVideoPlayer(
          videoPath: post['videoPath'],
          userName: post['user'],
          userAvatar: post['avatar'],
          description: post['content'],
          likes: post['likes'],
          isLiked: post['liked'],
          time: post['time'],
        );
      }
    }
  }
  
  /// Report post
  void onReportPost(int index) {
    if (index >= 0 && index < posts.length) {
      final post = posts[index];
      NavigationUtil.toReport(
        reportedType: 'post',
        reportedUserName: post['user'] ?? 'Unknown',
        reportedContent: post['content'] ?? '',
      );
    }
  }
  
  /// Navigate to topic detail
  void onTopicItemTap(int index) {
    if (index >= 0 && index < hotTopics.length) {
      final topic = hotTopics[index];
      // Pass topic data to detail page
      NavigationUtil.toTopicDetail(
        topicTitle: topic['title'],
        topicViews: topic['views'],
      );
    }
  }
}
