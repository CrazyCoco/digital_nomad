import 'package:get/get.dart';

class FollowListLogic extends GetxController {
  // 0: Following, 1: Followers, 2: Friends
  int selectedTab = 0;
  final List<String> tabs = ['Following', 'Followers', 'Friends'];
  
  // 关注列表
  List<Map<String, dynamic>> followingList = [
    {'name': 'Alice Johnson', 'bio': 'Travel blogger', 'isFollowing': true, 'avatar': 'images/Ellipse 783@3x(1).png'},
    {'name': 'Bob Smith', 'bio': 'Photographer', 'isFollowing': true, 'avatar': 'images/Ellipse 783@3x(2).png'},
    {'name': 'Carol White', 'bio': 'Digital nomad', 'isFollowing': false, 'avatar': 'images/Ellipse 783@3x(3).png'},
    {'name': 'David Brown', 'bio': 'Software engineer', 'isFollowing': true, 'avatar': 'images/Ellipse 783@3x(4).png'},
  ];
  
  // 粉丝列表
  List<Map<String, dynamic>> followersList = [
    {'name': 'Emma Davis', 'bio': 'Content creator', 'isFollowing': false, 'avatar': 'images/Ellipse 783@3x(5).png'},
    {'name': 'Frank Miller', 'bio': 'Designer', 'isFollowing': true, 'avatar': 'images/Ellipse 783@3x(6).png'},
    {'name': 'Grace Wilson', 'bio': 'Writer', 'isFollowing': false, 'avatar': 'images/Ellipse 783@3x(7).png'},
  ];
  
  // 朋友列表
  List<Map<String, dynamic>> friendsList = [
    {'name': 'Henry Moore', 'bio': 'Entrepreneur', 'online': true, 'avatar': 'images/Ellipse 783@3x(8).png'},
    {'name': 'Iris Taylor', 'bio': 'Artist', 'online': false, 'avatar': 'images/Ellipse 1293@3x.png'},
    {'name': 'Jack Anderson', 'bio': 'Developer', 'online': true, 'avatar': 'images/Ellipse 1293@3x(1).png'},
    {'name': 'Kate Thomas', 'bio': 'Marketer', 'online': false, 'avatar': 'images/Ellipse 1651@3x.png'},
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
