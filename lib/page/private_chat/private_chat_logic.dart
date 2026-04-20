import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateChatLogic extends GetxController {
  String userName = '';
  String userAvatar = '';
  
  List<Map<String, dynamic>> messages = [
    {'user': 'Other', 'message': 'Hello! How are you?', 'time': '10:00 AM', 'isMe': false},
    {'user': 'You', 'message': 'Hi! I\'m doing great, thanks!', 'time': '10:01 AM', 'isMe': true},
    {'user': 'Other', 'message': 'That\'s wonderful to hear!', 'time': '10:02 AM', 'isMe': false},
  ];
  
  final TextEditingController messageController = TextEditingController();
  
  void initialize(String name, String avatar) {
    userName = name;
    userAvatar = avatar;
    update();
  }
  
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
    
    // Simulate reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      messages.add({
        'user': userName,
        'message': 'Thanks for your message! 😊',
        'time': 'Now',
        'isMe': false,
      });
      update();
    });
  }
  
  void onBack() => Get.back();
  
  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
