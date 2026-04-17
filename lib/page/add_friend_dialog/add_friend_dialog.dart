import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendDialog {
  static void show({required String userName, required String userAvatar}) {
    final TextEditingController messageController = TextEditingController();
    
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: Column(
          children: [
            const Text('Add Friend'),
            const SizedBox(height: 16),
            // User info
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBBDEFB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 30, color: Color(0xFF2196F3)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CupertinoTextField(
            controller: messageController,
            maxLines: 3,
            placeholder: 'Add a message (optional)',
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
              // TODO: Send friend request
              print('Friend request sent to: $userName');
              print('Message: ${messageController.text}');
              
              Get.snackbar(
                'Success',
                'Friend request sent',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }
}
