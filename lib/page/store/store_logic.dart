import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';

class StoreLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  int selectedTab = 3;
  
  // Friends list data from Realm
  List<Map<String, dynamic>> friendsList = [];

  @override
  void onInit() {
    super.onInit();
    loadFriends();
  }

  /// Load friends from Realm (mutual follows)
  void loadFriends() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null) {
      return;
    }
    
    // Get users I'm following
    final followingUsers = _realmService.getFollowingUsers(currentUserId);
    // Get my followers
    final followersUsers = _realmService.getFollowersUsers(currentUserId);
    
    // Friends are mutual follows
    final friendIds = followingUsers
        .where((following) => followersUsers.any((follower) => follower.id == following.id))
        .map((user) => user.id)
        .toSet();
    
    // Build friends list
    friendsList = followingUsers
        .where((user) => friendIds.contains(user.id))
        .map((user) => {
          'id': user.id,
          'name': user.name,
          'avatar': user.avatar ?? 'images/head_1.jpg',
          'bio': user.bio ?? 'Digital Nomad',
          'isOnline': user.isOnline,
          'postsCount': user.postsCount,
        }).toList();
    
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectTab(int index) {
    selectedTab = index;
    update();
  }

  /// Remove friend (unfollow both ways)
  void removeFriend(int index) {
    if (index >= 0 && index < friendsList.length) {
      final box = GetStorage();
      final currentUserId = box.read('user_id') as String?;
      
      if (currentUserId == null) {
        return;
      }
      
      final friend = friendsList[index];
      final friendId = friend['id'] as String;
      
      // Unfollow both ways
      _realmService.unfollowUser(currentUserId, friendId);
      _realmService.unfollowUser(friendId, currentUserId);
      
      friendsList.removeAt(index);
      update();
      
      Get.snackbar(
        'Removed',
        'Friend removed successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
  
  /// Navigate to user page
  void onUserTap(String userName) {
    NavigationUtil.toUserPage(userName: userName);
    // Refresh data when returning
    Future.delayed(Duration.zero, () {
      loadFriends();
    });
  }
  
  /// Navigate to private chat
  void onChatTap(String userName, String userAvatar) {
    NavigationUtil.toPrivateChat(
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
