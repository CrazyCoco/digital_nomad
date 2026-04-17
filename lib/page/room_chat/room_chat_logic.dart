import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomChatLogic extends GetxController {
  String roomName = 'Travel Enthusiasts';
  int membersCount = 156;
  
  List<Map<String, dynamic>> messages = [
    {'user': 'Alice', 'message': 'Hey everyone!', 'time': '10:00 AM', 'isMe': false},
    {'user': 'You', 'message': 'Hi Alice!', 'time': '10:01 AM', 'isMe': true},
    {'user': 'Bob', 'message': 'Welcome to the room', 'time': '10:02 AM', 'isMe': false},
  ];
  
  final TextEditingController messageController = TextEditingController();
  
  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;
    
    messages.add({
      'user': 'You',
      'message': messageController.text,
      'time': 'Now',
      'isMe': true,
    });
    
    messageController.clear();
    update();
  }
  
  void onBack() => Get.back();
  
  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
