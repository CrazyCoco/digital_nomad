import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';

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
  
  // Posts data
  List<Map<String, dynamic>> posts = [];
  
  @override
  void onInit() {
    super.onInit();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['userName'] != null) {
      loadUserData(args['userName']);
    }
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
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    if (currentUserId != null && currentUserId != userId) {
      isFollowing = _realmService.isFollowing(currentUserId, userId);
    } else {
      isFollowing = false;
    }
    
    // Load user's posts from Realm
    final userPosts = _realmService.getPostsByUserId(user.id);
    posts = userPosts.map((post) => {
      'id': post.id,
      'image': post.image ?? '',
      'likes': post.likes,
      'comments': post.comments,
      'time': _formatTime(post.createdAt),
      'liked': post.isLiked,
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
  
  void selectTab(int index) {
    selectedTab = index;
    update();
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
  }
  
  void toggleLike(int index) {
    if (index >= 0 && index < posts.length) {
      final post = posts[index];
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
      userAvatar: userAvatar,
    );
  }
  
  void onMoreOptions() {
    // TODO: Show more options menu
    print('More options');
  }
}
