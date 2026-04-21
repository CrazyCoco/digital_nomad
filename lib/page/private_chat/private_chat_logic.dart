import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../model/chat_message.dart';
import '../../model/user.dart';

class PrivateChatLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  String userName = '';
  String userId = '';
  String userAvatar = '';
  String conversationId = '';
  
  List<ChatMessage> messages = [];
  
  final TextEditingController messageController = TextEditingController();
  
  void initialize(String name, String avatar) {
    userName = name;
    userAvatar = avatar;
    
    // Find user ID by name
    final users = _realmService.getAllUsers();
    final user = users.firstWhere(
      (u) => u.name == name,
      orElse: () => User('unknown', name),
    );
    userId = user.id;
    conversationId = 'private_$userId';
    
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
    
    // Update conversation last message
    _realmService.upsertPrivateConversation(
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      lastMessage: messageController.text,
      lastMessageTime: now,
      isOnline: true,
    );
    
    messageController.clear();
    
    // Reload messages to show the new one
    loadMessages();
    update();
  }
  
  void onBack() => Get.back();
  
  /// Show chat options menu (Block & Report)
  void showOptionsMenu() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null || userId.isEmpty) return;
    
    // Check if already blocked
    final isBlocked = _realmService.isBlocked(currentUserId, userId);
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                isBlocked ? Icons.block : Icons.block_outlined,
                color: isBlocked ? Colors.grey : Colors.orange,
              ),
              title: Text(isBlocked ? 'Unblock User' : 'Block User'),
              subtitle: Text(
                isBlocked 
                    ? 'Allow this user to contact you again'
                    : 'This user won\'t be able to contact you',
              ),
              onTap: () {
                Get.back();
                toggleBlock(currentUserId);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.flag_outlined, color: Colors.red),
              title: const Text('Report User'),
              subtitle: const Text('Report inappropriate behavior'),
              onTap: () {
                Get.back();
                showReportDialog();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  
  /// Toggle block/unblock user
  void toggleBlock(String currentUserId) {
    if (_realmService.isBlocked(currentUserId, userId)) {
      // Unblock
      _realmService.unblockUser(currentUserId, userId);
      Get.snackbar(
        'Unblocked',
        '$userName has been unblocked',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Block - Show iOS style confirmation dialog
      showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Block User'),
          content: Text(
            'Are you sure you want to block $userName? They won\'t be able to see your posts or contact you.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Get.back();
                _realmService.blockUser(currentUserId, userId);
                Get.snackbar(
                  'Blocked',
                  '$userName has been blocked',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text('Block'),
            ),
          ],
        ),
      );
    }
  }
  
  /// Show report dialog
  void showReportDialog() {
    final TextEditingController reasonController = TextEditingController();
    
    Get.defaultDialog(
      title: 'Report User',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Why are you reporting $userName?',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: reasonController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter reason for report...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          final reason = reasonController.text.trim();
          if (reason.isEmpty) {
            Get.snackbar(
              'Error',
              'Please enter a reason',
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          
          Get.back();
          
          // Save report to Realm
          final box = GetStorage();
          final currentUserId = box.read('user_id') as String?;
          final currentUserName = box.read('user_name') as String? ?? 'Anonymous';
          
          if (currentUserId != null) {
            _realmService.reportUser(
              reporterId: currentUserId,
              reporterName: currentUserName,
              reportedUserId: userId,
              reportedUserName: userName,
              reason: reason,
            );
            
            Get.snackbar(
              'Success',
              'Report submitted successfully',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        child: const Text('Submit Report'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
    );
  }
  
  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
