import 'package:get/get.dart';

class StoreLogic extends GetxController {
  int selectedTab = 3;

  // Friend requests data
  final List<Map<String, dynamic>> friendRequests = [
    {
      'name': 'Raya',
      'gender': 'Female',
      'message': 'Hello, I\'m Raya~',
      'time': '5 mins ago',
      'unread': 2,
    },
    {
      'name': 'Raya',
      'gender': 'Male',
      'message': 'Hello, I\'m Raya~',
      'time': '5 mins ago',
      'unread': 2,
    },
    {
      'name': 'Raya',
      'gender': 'Female',
      'message': 'Hello, I\'m Raya~',
      'time': '5 mins ago',
      'unread': 2,
    },
    {
      'name': 'Raya',
      'gender': 'Female',
      'message': 'Hello, I\'m Raya~',
      'time': '5 mins ago',
      'unread': 2,
    },
  ];

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

  void deleteFriendRequest(int index) {
    friendRequests.removeAt(index);
    update();
  }
}
