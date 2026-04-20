import 'package:get/get.dart';

import '../../comm/realm_service.dart';

class TopicDetailLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  String topicTitle = '#Topic';
  String topicViews = '0';
  String topicDescription = '';
  int postsCount = 0;
  int participantsCount = 0;
  
  List<Map<String, dynamic>> posts = [];
  
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
      'likes': post.likes,
      'liked': post.isLiked,
      'comments': post.comments,
      'time': _formatTime(post.createdAt),
    }).toList();
    
    postsCount = posts.length;
    // Unique users who posted with this topic
    participantsCount = posts.map((p) => p['userId']).toSet().length;
    
    update();
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
    Get.back();
    // TODO: Navigate to user page
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
}
