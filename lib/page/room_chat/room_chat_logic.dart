import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../comm/realm_service.dart';
import '../../model/chat_message.dart';
import '../../routes/app_routes.dart';

class RoomChatLogic extends GetxController {
  final RealmService _realmService = RealmService();
  final ImagePicker _picker = ImagePicker();
  
  String roomName = '';
  int membersCount = 0;
  String conversationId = '';
  
  List<ChatMessage> messages = [];
  
  final TextEditingController messageController = TextEditingController();
  
  void initialize(String name) {
    roomName = name;
    // Generate conversationId from room name (convert to lowercase with underscores)
    conversationId = 'room_${name.toLowerCase().replaceAll(' ', '_')}';
    
    // Load real room data from Realm
    final room = _realmService.getChatRoomByName(name);
    if (room != null) {
      membersCount = room.membersCount;
    } else {
      // Fallback: set default member count
      membersCount = 150 + (name.length * 10);
    }
    
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
    
    if (currentUserId == null) return;
    
    // Get real user name from Realm
    final currentUser = _realmService.getUserById(currentUserId);
    final currentUserName = currentUser?.name ?? 'You';
    
    final now = DateTime.now();
    final messageId = 'msg_${now.millisecondsSinceEpoch}';
    
    // Get user avatar
    final userAvatar = currentUser?.avatar;
    
    // Create and save message to Realm
    final message = ChatMessage(
      messageId,
      conversationId,
      currentUserId,
      currentUserName,
      messageController.text,
      senderAvatar: userAvatar,
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
  
  /// Pick and send image
  Future<void> pickAndSendImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (image == null) return;
      
      final box = GetStorage();
      final currentUserId = box.read('user_id') as String?;
      
      if (currentUserId == null) return;
      
      // Get user info
      final currentUser = _realmService.getUserById(currentUserId);
      final currentUserName = currentUser?.name ?? 'You';
      final userAvatar = currentUser?.avatar;
      
      final now = DateTime.now();
      final messageId = 'msg_img_${now.millisecondsSinceEpoch}';
      
      // Create message with image path
      final message = ChatMessage(
        messageId,
        conversationId,
        currentUserId,
        currentUserName,
        '', // Empty text for image message
        senderAvatar: userAvatar,
        imageUrl: image.path, // Store image path in imageUrl field
        messageType: 1, // 1 for image
        isRead: false,
        createdAt: now,
      );
      
      _realmService.sendMessage(message);
      
      // Reload messages
      loadMessages();
      update();
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  
  /// Report a message
  void onReportMessage(ChatMessage message) {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null) return;
    
    // Get reporter info
    final currentUser = _realmService.getUserById(currentUserId);
    final reporterName = currentUser?.name ?? 'Anonymous';
    
    NavigationUtil.toReport(
      reportedType: 'message',
      reportedUserName: message.senderName,
      reportedContent: message.content,
    );
  }
  
  /// Get current user info for reporting
  Map<String, dynamic> getReporterInfo() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null) {
      return {'userId': '', 'userName': 'Anonymous'};
    }
    
    final currentUser = _realmService.getUserById(currentUserId);
    return {
      'userId': currentUserId,
      'userName': currentUser?.name ?? 'Anonymous',
    };
  }
  
  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
