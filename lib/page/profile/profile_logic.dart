import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';

class ProfileLogic extends GetxController {
  final RealmService _realmService = RealmService();

  int selectedTab = 4;
  int contentTab = 0;

  // Current user info
  String currentUserId = '';
  String currentUserName = 'User';
  String currentUserAvatar = 'images/head_1.jpg';
  String currentUserBio = '';
  String currentUserTitle = ''; // 头衔
  int followingCount = 0;
  int followersCount = 0;
  int friendsCount = 0;

  // 视频列表 - 从 Realm 加载
  List<Map<String, dynamic>> videos = [];

  // 帖子列表 - 从 Realm 加载
  List<Map<String, dynamic>> posts = [];

  // Friend request count
  int friendRequestCount = 0;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
    loadFriendRequestCount();
  }

  /// Load current user data from Realm
  void loadCurrentUser() {
    final box = GetStorage();
    final userId = box.read('user_id') as String?;

    if (userId != null) {
      currentUserId = userId;
      final user = _realmService.getUserById(userId);

      if (user != null) {
        currentUserId = user.id;
        currentUserName = user.name;
        currentUserAvatar = user.avatar ?? 'images/head_1.jpg';
        currentUserBio = user.bio ?? '';
        currentUserTitle = user.title ?? ''; // 加载头衔
        
        // 从实际的 Follow 记录计算数量，确保准确性
        final followingUsers = _realmService.getFollowingUsers(userId);
        final followerUsers = _realmService.getFollowersUsers(userId);
        
        followingCount = followingUsers.length;
        followersCount = followerUsers.length;
        
        // 计算朋友数量：互相关注的用户
        final followingIds = followingUsers.map((u) => u.id).toSet();
        final followerIds = followerUsers.map((u) => u.id).toSet();
        friendsCount = followingIds.intersection(followerIds).length;

        // Load user's posts
        final userPosts = _realmService.getPostsByUserId(userId);
        posts = userPosts
            .map(
              (post) => {
                'id': post.id,
                'user': post.userName,
                'userId': post.userId,
                'time': _formatTime(post.createdAt),
                'content': post.description ?? 'No description',
                'views': '${post.views}',
                'likes': post.likes,
                'liked': post.isLiked,
                'avatar': post.userAvatar ?? 'images/head_1.jpg',
                'image': post.image,
              },
            )
            .toList();

        // Load user's videos (posts with isVideo=true)
        final userVideos = userPosts.where((p) => p.isVideo).toList();
        videos = userVideos
            .map(
              (post) => {
                'title': post.description ?? 'Video',
                'thumbnail': post.image ?? '',
                'videoPath': post.videoPath ?? '',
                'duration': '2:30',
                'views': '${post.views}',
                'time': _formatTime(post.createdAt),
                'postId': post.id,
                'userId': post.userId,
                'userName': post.userName,
                'userAvatar': post.userAvatar,
                'description': post.description ?? '',
                'likes': post.likes,
                'isLiked': post.isLiked,
              },
            )
            .toList();
      }
    }

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

  /// Format user ID to numeric display
  String formatUserId(String userId) {
    // If the ID is already numeric, return as is
    if (RegExp(r'^\d+$').hasMatch(userId)) {
      return userId;
    }
    
    // Convert string ID to a numeric representation
    // Use hashCode and ensure it's positive and formatted nicely
    final hash = userId.hashCode.abs();
    // Format as an 8-10 digit number
    return hash.toString().padLeft(8, '0');
  }

  /// Load friend request count from Realm
  void loadFriendRequestCount() {
    if (currentUserId.isEmpty) return;
    
    final requests = _realmService.getReceivedFriendRequests(currentUserId);
    friendRequestCount = requests.length;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectTab(int index) {
    selectedTab = index;
    update();
  }

  void selectContentTab(int index) {
    contentTab = index;
    update();
  }

  void onEditProfile() {
    NavigationUtil.toEditProfile()?.then((result) {
      // Refresh user data when returning from edit profile
      if (result == true) {
        loadCurrentUser();
      }
    });
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
    if (index >= 0 && index < videos.length) {
      final video = videos[index];
      NavigationUtil.toVideoPlayer(
        videoPath: video['videoPath'],
        userName: video['userName'] ?? currentUserName,
        userAvatar: video['userAvatar'] ?? currentUserAvatar,
        description: video['description'] ?? video['title'] ?? '',
        likes: video['likes'] ?? 0,
        isLiked: video['isLiked'] ?? false,
        time: video['time'] ?? '',
      );
    }
  }

  void onPostAuthorTap(int index) {
    if (index >= 0 && index < posts.length) {
      final post = posts[index];
      final userName = post['user'] as String?;
      if (userName != null) {
        NavigationUtil.toUserPage(userName: userName);
        // Refresh posts when returning
        Future.delayed(Duration.zero, () {
          loadCurrentUser();
        });
      }
    }
  }
}
