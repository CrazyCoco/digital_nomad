import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';

class TopicDetailLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  String topicTitle = '#Topic';
  String topicViews = '0';
  String topicDescription = '';
  int postsCount = 0;
  int participantsCount = 0;
  bool isJoined = false;
  
  List<Map<String, dynamic>> posts = [];
  List<Map<String, dynamic>> topContributors = [];
  
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      topicTitle = args['topicTitle'] ?? topicTitle;
      topicViews = args['topicViews'] ?? '0';
    }
    loadTopicData();
  }
  
  void loadTopicData() {
    // Load all posts from Realm
    final allPosts = _realmService.getAllPosts();
    
    // Filter posts that contain this topic hashtag
    final topicHashtag = topicTitle.startsWith('#') ? topicTitle : '#$topicTitle';
    final filteredPosts = allPosts.where((post) {
      final description = post.description ?? '';
      return description.contains(topicHashtag);
    }).toList();
    
    // Convert to display format
    posts = filteredPosts.map((post) => {
      'id': post.id,
      'user': post.userName,
      'userId': post.userId,
      'avatar': post.userAvatar ?? 'images/head_1.jpg',
      'content': post.description ?? 'No description',
      'image': post.image ?? '',
      'images': post.image != null && post.image!.isNotEmpty ? [post.image] : [],
      'likes': post.likes,
      'liked': post.isLiked,
      'comments': post.comments,
      'views': (post.likes * 10 + post.comments * 5).toString(),
      'time': _formatTime(post.createdAt),
      'createdAt': post.createdAt,
    }).toList();
    
    // Sort posts by time (newest first)
    posts.sort((a, b) {
      final aTime = a['createdAt'] as DateTime?;
      final bTime = b['createdAt'] as DateTime?;
      if (aTime == null || bTime == null) return 0;
      return bTime.compareTo(aTime);
    });
    
    postsCount = posts.length;
    // Unique users who posted with this topic
    participantsCount = posts.map((p) => p['userId']).toSet().length;
    
    // Generate topic description
    _generateTopicDescription();
    
    // Load top contributors
    _loadTopContributors();
    
    update();
  }
  
  void _generateTopicDescription() {
    final topicName = topicTitle.replaceAll('#', '');
    final descriptions = {
      'DigitalNomad': 'Share your digital nomad lifestyle and remote work tips',
      'RemoteWork': 'Tips and experiences for working remotely',
      'TravelTips': 'Best travel advice and destination guides',
      'CoworkingSpace': 'Discover the best coworking spaces around the world',
      'NomadLife': 'Living the nomad dream, one city at a time',
    };
    
    topicDescription = descriptions[topicName] ?? 'Join the conversation about $topicName';
  }
  
  void _loadTopContributors() {
    // Count posts per user
    Map<String, Map<String, dynamic>> userStats = {};
    
    for (final post in posts) {
      final userId = post['userId'] as String;
      final userName = post['user'] as String;
      final userAvatar = post['avatar'] as String;
      
      if (!userStats.containsKey(userId)) {
        userStats[userId] = {
          'userId': userId,
          'userName': userName,
          'avatar': userAvatar,
          'postCount': 0,
          'totalLikes': 0,
        };
      }
      
      userStats[userId]!['postCount'] = (userStats[userId]!['postCount'] as int) + 1;
      userStats[userId]!['totalLikes'] = (userStats[userId]!['totalLikes'] as int) + (post['likes'] as int);
    }
    
    // Sort by post count and take top 5
    topContributors = userStats.values.toList()
      ..sort((a, b) => (b['postCount'] as int).compareTo(a['postCount'] as int));
    
    if (topContributors.length > 5) {
      topContributors = topContributors.sublist(0, 5);
    }
  }
  
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
  
  void onBack() => Get.back();
  
  void onUserTap(String userName) {
    NavigationUtil.toUserPage(userName: userName);
  }
  
  void onContributorTap(String userId, String userName) {
    NavigationUtil.toUserPage(userName: userName);
  }
  
  void onPostTap(int index) {
    if (index >= 0 && index < posts.length) {
      final post = posts[index];
      Get.toNamed('/postDetail', arguments: post);
    }
  }
  
  void onLike(int index) {
    if (index >= 0 && index < posts.length) {
      final post = posts[index];
      final postId = post['id'] as String?;
      if (postId != null) {
        _realmService.toggleLike(postId);
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
  
  void onShare(int index) {
    if (index >= 0 && index < posts.length) {
      Get.snackbar(
        'Shared!',
        'Post shared to your timeline',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
  
  void onJoinTopic() {
    isJoined = !isJoined;
    if (isJoined) {
      Get.snackbar(
        'Joined!',
        'You are now following $topicTitle',
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.check_circle, color: Colors.green),
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Left',
        'You unfollowed $topicTitle',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
    update();
  }
  
  void onCreatePost() {
    Get.snackbar(
      'Create Post',
      'Use the +Post button to share with #$topicTitle',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
