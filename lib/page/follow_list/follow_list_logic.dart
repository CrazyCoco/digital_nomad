import 'package:get/get.dart';

class FollowListLogic extends GetxController {
  // 0: Following, 1: Followers, 2: Friends
  int selectedTab = 0;
  final List<String> tabs = ['Following', 'Followers', 'Friends'];
  
  // 关注列表
  List<Map<String, dynamic>> followingList = [
    {'name': 'Alice Johnson', 'bio': 'Travel blogger', 'isFollowing': true, 'avatar': 'images/head_1.jpg'},
    {'name': 'Bob Smith', 'bio': 'Photographer', 'isFollowing': true, 'avatar': 'images/head_2.jpg'},
    {'name': 'Carol White', 'bio': 'Digital nomad', 'isFollowing': false, 'avatar': 'images/head_3.jpg'},
    {'name': 'David Brown', 'bio': 'Software engineer', 'isFollowing': true, 'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg'},
  ];
  
  // 粉丝列表
  List<Map<String, dynamic>> followersList = [
    {'name': 'Emma Davis', 'bio': 'Content creator', 'isFollowing': false, 'avatar': 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg'},
    {'name': 'Frank Miller', 'bio': 'Designer', 'isFollowing': true, 'avatar': 'images/799ddffd8fbda40cd47b3d6887ed2d6c.jpg'},
    {'name': 'Grace Wilson', 'bio': 'Writer', 'isFollowing': false, 'avatar': 'images/bf96945afb419442511807418b87dc16.jpg'},
  ];
  
  // 朋友列表
  List<Map<String, dynamic>> friendsList = [
    {'name': 'Henry Moore', 'bio': 'Entrepreneur', 'online': true, 'avatar': 'images/e8b24fae0b4d0815af9ddda8f1476ff8.jpg'},
    {'name': 'Iris Taylor', 'bio': 'Artist', 'online': false, 'avatar': 'images/f04f96e8b6d909e39f132371413ae7d2.jpg'},
    {'name': 'Jack Anderson', 'bio': 'Developer', 'online': true, 'avatar': 'images/head_1.jpg'},
    {'name': 'Kate Thomas', 'bio': 'Marketer', 'online': false, 'avatar': 'images/head_2.jpg'},
  ];
  
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  void toggleFollow(int index) {
    if (selectedTab == 0) {
      followingList[index]['isFollowing'] = !followingList[index]['isFollowing'];
    } else if (selectedTab == 1) {
      followersList[index]['isFollowing'] = !followersList[index]['isFollowing'];
    }
    update();
  }
  
  void onUserTap(String name) {
    // TODO: Navigate to user profile
    print('Tap on user: $name');
  }
  
  void onBack() {
    Get.back();
  }
}
