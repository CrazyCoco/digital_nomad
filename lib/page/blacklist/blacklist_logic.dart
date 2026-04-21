import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../model/user.dart';

class BlacklistLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  // 黑名单用户列表
  List<User> blacklistUsers = [];
  
  @override
  void onInit() {
    super.onInit();
    loadBlocklist();
  }
  
  /// 从Realm加载黑名单数据
  void loadBlocklist() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId != null) {
      blacklistUsers = _realmService.getBlocklistUsers(currentUserId);
      update();
    }
  }
  
  /// 取消拉黑
  void unblockUser(int index) {
    if (index < 0 || index >= blacklistUsers.length) return;
    
    final user = blacklistUsers[index];
    
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Unblock User'),
        content: Text(
          'Are you sure you want to unblock ${user.name}?',
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
              
              final box = GetStorage();
              final currentUserId = box.read('user_id') as String?;
              
              if (currentUserId != null) {
                // 从数据库中删除
                _realmService.unblockUser(currentUserId, user.id);
                
                // 刷新列表
                loadBlocklist();
                
                Get.snackbar(
                  'Success',
                  '${user.name} has been unblocked',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
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
