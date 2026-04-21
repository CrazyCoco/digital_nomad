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

  // 视频列表 - 从 Realm 加载
  List<Map<String, dynamic>> videos = [];

  // 帖子列表 - 从 Realm 加载
  List<Map<String, dynamic>> posts = [];

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  /// Load current user data from Realm
  void loadCurrentUser() {
    final box = GetStorage();
    final userId = box.read('user_id') as String?;

    if (userId != null) {
      currentUserId = userId;
      final user = _realmService.getUserById(userId);

      if (user != null) {
        currentUserName = user.name;
        currentUserAvatar = user.avatar ?? 'images/head_1.jpg';

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
                'views': '${(post.likes * 10 + post.comments * 5)}',
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
                'views': '${post.likes}',
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
    NavigationUtil.toEditProfile();
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
