import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class ChatLogic extends GetxController {
  int selectedTab = 0; // 0: Private Chats, 1: Room Chats
  final List<String> tabs = ['Chats', 'Rooms'];
  
  // 私聊列表
  final List<Map<String, dynamic>> privateChats = [
    {
      'name': 'Alice Johnson',
      'avatar': 'images/head_1.jpg',
      'lastMessage': 'Hey! How are you doing?',
      'time': '2 mins ago',
      'unread': 2,
      'online': true,
    },
    {
      'name': 'Michael Chen',
      'avatar': 'images/head_2.jpg',
      'lastMessage': 'Let\'s meet up tomorrow!',
      'time': '1 hour ago',
      'unread': 0,
      'online': false,
    },
    {
      'name': 'Sarah Wilson',
      'avatar': 'images/head_3.jpg',
      'lastMessage': 'Thanks for the recommendation',
      'time': '3 hours ago',
      'unread': 1,
      'online': true,
    },
    {
      'name': 'David Lee',
      'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
      'lastMessage': 'See you at the cafe',
      'time': '1 day ago',
      'unread': 0,
      'online': false,
    },
  ];
  
  // 房间聊天列表
  final List<Map<String, dynamic>> chatRooms = [
    {'name': 'Cafe Nomads', 'members': 156, 'hot': true},
    {'name': 'Travel Enthusiasts', 'members': 243, 'hot': true},
    {'name': 'Digital Nomads Asia', 'members': 189, 'hot': false},
    {'name': 'Remote Workers', 'members': 312, 'hot': true},
    {'name': 'Photography Lovers', 'members': 98, 'hot': false},
    {'name': 'Tech Talk', 'members': 421, 'hot': true},
  ];
  
  @override
  void onReady() { super.onReady(); }
  @override
  void onClose() { super.onClose(); }
  
  void selectTab(int index) { 
    selectedTab = index;
    update();
  }
  
  void openPrivateChat(int index) {
    final chat = privateChats[index];
    NavigationUtil.toPrivateChat(
      userName: chat['name'],
      userAvatar: chat['avatar'],
    );
  }
  
  void joinRoomChat(int index) {
    final room = chatRooms[index];
    NavigationUtil.toRoomChat(roomName: room['name']);
  }
}
