import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlacklistLogic extends GetxController {
  // 黑名单列表
  List<Map<String, dynamic>> blacklist = [
    {
      'name': 'Spam User 1',
      'bio': 'Suspicious account',
      'blockedAt': '2024-01-15',
    },
    {
      'name': 'Abusive User',
      'bio': 'Harassment reported',
      'blockedAt': '2024-01-10',
    },
    {
      'name': 'Fake Account',
      'bio': 'Impersonation',
      'blockedAt': '2024-01-05',
    },
  ];
  
  void unblockUser(int index) {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Unblock User'),
        content: Text(
          'Are you sure you want to unblock ${blacklist[index]['name']}?',
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
              print('Unblocked: ${blacklist[index]['name']}');
              blacklist.removeAt(index);
              update();
              
              Get.snackbar(
                'Success',
                'User has been unblocked',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Unblock'),
          ),
        ],
      ),
    );
  }
  
  void onBack() {
    Get.back();
  }
}
