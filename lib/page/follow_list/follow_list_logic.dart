import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';

class FollowListLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  // 0: Following, 1: Followers, 2: Friends
  int selectedTab = 0;
  final List<String> tabs = ['Following', 'Followers', 'Friends'];
  
  // Data lists
  List<Map<String, dynamic>> followingList = [];
  List<Map<String, dynamic>> followersList = [];
  List<Map<String, dynamic>> friendsList = [];
  
  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  
  /// Load data from Realm
  void loadData() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null) {
      return;
    }
    
    // Load following users
    final followingUsers = _realmService.getFollowingUsers(currentUserId);
    followingList = followingUsers.map((user) => {
      'id': user.id,
      'name': user.name,
      'bio': user.bio ?? 'No bio',
      'isFollowing': true,
      'avatar': user.avatar ?? 'images/head_1.jpg',
    }).toList();
    
    // Load followers users
    final followersUsers = _realmService.getFollowersUsers(currentUserId);
    followersList = followersUsers.map((user) {
      // Check if current user is following back
      final isFollowingBack = _realmService.isFollowing(currentUserId, user.id);
      return {
        'id': user.id,
        'name': user.name,
        'bio': user.bio ?? 'No bio',
        'isFollowing': isFollowingBack,
        'avatar': user.avatar ?? 'images/head_1.jpg',
      };
    }).toList();
    
    // Load friends (mutual follows)
    friendsList = followingList.where((following) {
      return followersList.any((follower) => follower['id'] == following['id']);
    }).toList();
    
    update();
  }
  
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  void toggleFollow(int index) {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null) {
      return;
    }
    
    if (selectedTab == 0) {
      // Unfollow from Following tab
      final user = followingList[index];
      final targetUserId = user['id'] as String;
      
      _realmService.unfollowUser(currentUserId, targetUserId);
      followingList.removeAt(index);
      
      // Also remove from friends if exists
      friendsList.removeWhere((friend) => friend['id'] == targetUserId);
    } else if (selectedTab == 1) {
      // Follow back from Followers tab
      final user = followersList[index];
      final targetUserId = user['id'] as String;
      
      if (user['isFollowing']) {
        // Unfollow
        _realmService.unfollowUser(currentUserId, targetUserId);
        user['isFollowing'] = false;
        
        // Remove from friends
        friendsList.removeWhere((friend) => friend['id'] == targetUserId);
      } else {
        // Follow back
        _realmService.followUser(currentUserId, targetUserId);
        user['isFollowing'] = true;
        
        // Add to friends
        friendsList.add({
          'id': targetUserId,
          'name': user['name'],
          'bio': user['bio'],
          'avatar': user['avatar'],
        });
      }
    }
    
    update();
  }
  
  void onUserTap(String name) {
    NavigationUtil.toUserPage(userName: name);
  }
  
  void onBack() {
    Get.back();
  }
}
