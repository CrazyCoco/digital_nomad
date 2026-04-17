import 'package:get/get.dart';

class FriendRequestLogic extends GetxController {
  // 好友申请列表
  List<Map<String, dynamic>> requests = [
    {
      'name': 'Sarah Johnson',
      'bio': 'Travel enthusiast | Coffee lover',
      'mutualFriends': 5,
      'time': '2 hours ago',
      'avatar': 'images/Ellipse 1652@3x.png',
    },
    {
      'name': 'Michael Chen',
      'bio': 'Photographer & Blogger',
      'mutualFriends': 12,
      'time': '5 hours ago',
      'avatar': 'images/Ellipse 1653@3x.png',
    },
    {
      'name': 'Emily Davis',
      'bio': 'Digital nomad in Asia',
      'mutualFriends': 8,
      'time': '1 day ago',
      'avatar': 'images/Ellipse 783@3x(1).png',
    },
    {
      'name': 'James Wilson',
      'bio': 'Software engineer | Hiker',
      'mutualFriends': 3,
      'time': '2 days ago',
      'avatar': 'images/Ellipse 783@3x(2).png',
    },
  ];
  
  void acceptRequest(int index) {
    // TODO: Accept friend request
    print('Accepted request from: ${requests[index]['name']}');
    requests.removeAt(index);
    update();
    
    Get.snackbar(
      'Success',
      'Friend request accepted',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void declineRequest(int index) {
    // TODO: Decline friend request
    print('Declined request from: ${requests[index]['name']}');
    requests.removeAt(index);
    update();
  }
  
  void onBack() {
    Get.back();
  }
}
