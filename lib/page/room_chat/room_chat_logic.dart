import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../model/chat_message.dart';

class RoomChatLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  String roomName = '';
  int membersCount = 0;
  String conversationId = '';
  
  List<ChatMessage> messages = [];
  
  final TextEditingController messageController = TextEditingController();
  
  void initialize(String name) {
    roomName = name;
    // Generate conversationId from room name (convert to lowercase with underscores)
    conversationId = 'room_${name.toLowerCase().replaceAll(' ', '_')}';
    
    // Set random member count for demo
    membersCount = 150 + (name.length * 10);
    
    // Load messages from database
    loadMessages();
    update();
  }
  
  /// Load messages from Realm database
  void loadMessages() {
    if (conversationId.isEmpty) return;
    messages = _realmService.getMessagesByConversation(conversationId);
  }
  
  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;
    
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    final currentUserName = box.read('user_name') as String? ?? 'You';
    
    if (currentUserId == null) return;
    
    final now = DateTime.now();
    final messageId = 'msg_${now.millisecondsSinceEpoch}';
    
    // Create and save message to Realm
    final message = ChatMessage(
      messageId,
      conversationId,
      currentUserId,
      currentUserName,
      messageController.text,
      isRead: false,
      createdAt: now,
    );
    
    _realmService.sendMessage(message);
    
    messageController.clear();
    
    // Reload messages to show the new one
    loadMessages();
    update();
  }
  
  void onBack() => Get.back();
  
  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
