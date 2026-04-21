import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';
import '../home/home_logic.dart';

class UserPageLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  // 用户信息
  String userName = 'John Doe';
  String userId = '';
  String userAvatar = 'images/head_1.jpg';
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
  
  // Posts data (用户发布的帖子)
  List<Map<String, dynamic>> posts = [];
  
  // Liked posts data (用户点赞的帖子)
  List<Map<String, dynamic>> likedPosts = [];
  
  @override
  void onInit() {
    super.onInit();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['userName'] != null) {
      loadUserData(args['userName']);
    }
  }
  
  @override
  void onReady() {
    super.onReady();
    // Refresh follow status when page becomes visible
    refreshFollowStatus();
  }
  
  /// 加载用户数据
  void loadUserData(String name) {
    userName = name;
    
    // Find user in Realm
    final users = _realmService.getAllUsers();
    final user = users.firstWhere(
      (u) => u.name == name,
      orElse: () => users.isNotEmpty ? users.first : throw Exception('User not found'),
    );
    
    userId = user.id;
    userAvatar = user.avatar ?? 'images/head_1.jpg';
    userBio = user.bio ?? 'Digital nomad | Travel enthusiast | Coffee lover';
    followingCount = user.following;
    followersCount = user.followers;
    friendsCount = user.friends;
    postsCount = user.postsCount;
    
    // Check if current user is following this user
    refreshFollowStatus();
    
    // Load user's posts from Realm
    final userPosts = _realmService.getPostsByUserId(user.id);
    posts = userPosts.map((post) => {
      'id': post.id,
      'image': post.image ?? '',
      'likes': post.likes,
      'comments': post.comments,
      'time': _formatTime(post.createdAt),
      'liked': post.isLiked,
      'userId': post.userId,
      'userName': post.userName,
      'userAvatar': post.userAvatar,
    }).toList();
    
    // Load posts that user has liked
    final allPosts = _realmService.getAllPosts();
    likedPosts = allPosts.where((post) => post.isLiked).map((post) => {
      'id': post.id,
      'image': post.image ?? '',
      'likes': post.likes,
      'comments': post.comments,
      'time': _formatTime(post.createdAt),
      'liked': post.isLiked,
      'userId': post.userId,
      'userName': post.userName,
      'userAvatar': post.userAvatar,
    }).toList();
    
    update();
  }
  
  /// Refresh follow status from Realm
  void refreshFollowStatus() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    if (currentUserId != null && userId.isNotEmpty) {
      final newFollowStatus = _realmService.isFollowing(currentUserId, userId);
      if (newFollowStatus != isFollowing) {
        isFollowing = newFollowStatus;
        update();
      }
    }
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
  
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  /// Get current display posts based on selected tab
  List<Map<String, dynamic>> get displayPosts {
    if (selectedTab == 0) {
      return posts; // Posts tab
    } else {
      return likedPosts; // Likes tab
    }
  }
  
  void toggleFollow() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null || userId.isEmpty) {
      return;
    }
    
    if (isFollowing) {
      // Unfollow
      _realmService.unfollowUser(currentUserId, userId);
      followersCount--;
    } else {
      // Follow
      _realmService.followUser(currentUserId, userId);
      followersCount++;
    }
    
    isFollowing = !isFollowing;
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
  
  void toggleLike(int index) {
    final currentPosts = displayPosts;
    if (index >= 0 && index < currentPosts.length) {
      final post = currentPosts[index];
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
        
        // If we're in Likes tab and user unlikes, remove from list
        if (selectedTab == 1 && !post['liked']) {
          likedPosts.removeAt(index);
        }
        
        update();
      }
    }
  }
  
  void onBack() {
    Get.back();
  }
  
  void onEditProfile() {
    NavigationUtil.toEditProfile();
  }
  
  void onMessage() {
    NavigationUtil.toPrivateChat(
      userName: userName,
      userAvatar: userAvatar,
    );
  }
  
  void onMoreOptions() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    // Check if already blocked
    final isBlocked = currentUserId != null && userId.isNotEmpty 
        ? _realmService.isBlocked(currentUserId, userId) 
        : false;
    
    // Show more options menu
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                isBlocked ? Icons.block : Icons.block_outlined,
                color: isBlocked ? Colors.grey : Colors.orange,
              ),
              title: Text(isBlocked ? 'Unblock User' : 'Block User'),
              onTap: () {
                Get.back();
                toggleBlock();
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag, color: Colors.red),
              title: const Text('Report User'),
              onTap: () {
                Get.back();
                NavigationUtil.toReport(
                  reportedType: 'user',
                  reportedUserName: userName,
                  reportedContent: '',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  /// Toggle block/unblock user
  void toggleBlock() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null || userId.isEmpty) {
      return;
    }
    
    if (_realmService.isBlocked(currentUserId, userId)) {
      // Unblock
      _realmService.unblockUser(currentUserId, userId);
      Get.snackbar(
        'Unblocked',
        '$userName has been unblocked',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Block - Show iOS style confirmation dialog
      showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Block User'),
          content: Text(
            'Are you sure you want to block $userName? They won\'t be able to see your posts or contact you.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Get.back();
                _realmService.blockUser(currentUserId, userId);
                Get.snackbar(
                  'Blocked',
                  '$userName has been blocked',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text('Block'),
            ),
          ],
        ),
      );
    }
  }
  
  /// Navigate to post detail
  void onPostTap(int index) {
    final currentPosts = displayPosts;
    if (index >= 0 && index < currentPosts.length) {
      NavigationUtil.toPostDetail(postData: currentPosts[index]);
    }
  }
}
