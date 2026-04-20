import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';

class HomeLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  // Tab controller
  int selectedTab = 0;
  
  // Category tabs
  final List<String> categories = ['Colab', 'Cafe', 'Outdoor'];
  int selectedCategory = 0;
  
  // Suggested users loaded from Realm
  List<Map<String, dynamic>> suggestedUsers = [];
  
  // Posts loaded from Realm
  List<Map<String, dynamic>> posts = [];
  
  @override
  void onInit() {
    super.onInit();
    loadSuggestedUsers();
    loadPosts();
  }
  
  /// Load suggested users from Realm
  void loadSuggestedUsers() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null) {
      return;
    }
    
    // Get all users except current user
    final allUsers = _realmService.getAllUsers();
    final otherUsers = allUsers.where((u) => u.id != currentUserId).toList();
    
    // Check follow status for each user
    suggestedUsers = otherUsers.map((user) {
      final isFollowing = _realmService.isFollowing(currentUserId, user.id);
      return {
        'id': user.id,
        'name': user.name,
        'online': user.isOnline,
        'avatar': user.avatar ?? 'images/head_1.jpg',
        'bio': user.bio ?? '',
        'isFollowing': isFollowing,
        'followers': user.followers,
      };
    }).toList();
    
    update();
  }
  
  /// Load posts from Realm database
  void loadPosts() {
    final category = categories[selectedCategory];
    final realmPosts = _realmService.getPostsByCategory(category);
    
    posts = realmPosts.map((post) => {
      'id': post.id,
      'user': post.userName,
      'userId': post.userId,
      'time': _formatTime(post.createdAt),
      'description': post.description ?? '',
      'likes': post.likes,
      'liked': post.isLiked,
      'weather': post.weather ?? 'sunny',
      'image': post.image ?? '',
      'avatar': post.userAvatar ?? 'images/head_1.jpg',
      'isVideo': post.isVideo,
      'videoPath': post.videoPath,
      'category': post.category,
    }).toList();
    
    update();
  }
  
  /// Format DateTime to readable string
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return 'Just now';
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inHours < 1) {
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
  
  /// Select category
  void selectCategory(int index) {
    selectedCategory = index;
    loadPosts(); // Reload posts from Realm when category changes
  }
  
  /// Get current category name
  String get currentCategory => categories[selectedCategory];
  
  /// Select bottom tab
  void selectTab(int index) {
    selectedTab = index;
    update();
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
  
  /// Navigate to post detail
  void onPostTap(int index) {
    final currentPosts = posts;
    if (index >= 0 && index < currentPosts.length) {
      NavigationUtil.toPostDetail(postData: currentPosts[index]);
    }
  }
  
  /// Play video
  void onPlayVideo(int index) {
    final currentPosts = posts;
    if (index >= 0 && index < currentPosts.length) {
      final post = currentPosts[index];
      if (post['isVideo'] == true && post['videoPath'] != null) {
        NavigationUtil.toVideoPlayer(
          videoPath: post['videoPath'],
          userName: post['user'] ?? 'Unknown',
          userAvatar: post['avatar'] ?? '',
          description: post['description'] ?? '',
          likes: post['likes'] ?? 0,
          isLiked: post['liked'] ?? false,
          time: post['time'] ?? '',
        );
      }
    }
  }
  
  /// Report post
  void onReportPost(int index) {
    final currentPosts = posts;
    if (index >= 0 && index < currentPosts.length) {
      final post = currentPosts[index];
      NavigationUtil.toReport(
        reportedType: 'post',
        reportedUserName: post['user'] ?? 'Unknown',
        reportedContent: post['description'] ?? '',
      );
    }
  }
  
  /// Toggle follow for suggested user
  void toggleFollowUser(int userIndex) {
    if (userIndex >= 0 && userIndex < suggestedUsers.length) {
      final box = GetStorage();
      final currentUserId = box.read('user_id') as String?;
      
      if (currentUserId == null) {
        return;
      }
      
      final user = suggestedUsers[userIndex];
      final targetUserId = user['id'] as String;
      
      if (user['isFollowing']) {
        // Unfollow
        _realmService.unfollowUser(currentUserId, targetUserId);
        user['isFollowing'] = false;
      } else {
        // Follow
        _realmService.followUser(currentUserId, targetUserId);
        user['isFollowing'] = true;
      }
      
      update();
    }
  }
  
  /// Refresh suggested users (called from other pages)
  void refreshSuggestedUsers() {
    loadSuggestedUsers();
  }
}
