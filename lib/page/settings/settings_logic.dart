import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_routes.dart';

class SettingsLogic extends GetxController {
  bool notifications = true;
  bool darkMode = false;
  String language = 'English';
  
  void toggleNotifications() {
    notifications = !notifications;
    update();
  }
  
  void toggleDarkMode() {
    darkMode = !darkMode;
    update();
  }
  
  void onBack() => Get.back();
  
  void onEditProfile() {
    // TODO: Navigate to edit profile
    print('Navigate to edit profile');
  }
  
  void onPrivacyPolicy() {
    NavigationUtil.toPrivacyPolicy();
  }
  
  void onTermsOfService() {
    NavigationUtil.toTermsOfService();
  }
  
  void onDeleteAccount() {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
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
              _performAccountDeletion();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
  
  void _performAccountDeletion() {
    // Clear all user data
    final box = GetStorage();
    box.remove('is_logged_in');
    box.remove('user_id');
    box.remove('username');
    box.remove('email');
    box.remove('avatar');
    // Add any other user-related data keys
    
    print('Account deleted successfully');
    
    // Show success message
    Get.snackbar(
      'Account Deleted',
      'Your account has been successfully deleted',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
    
    // Navigate to login page
    Future.delayed(const Duration(seconds: 1), () {
      NavigationUtil.toLoginIndex();
    });
  }
  
  void onLogout() {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
              
              // Clear user data
              final box = GetStorage();
              box.remove('is_logged_in');
              box.remove('user_id');
              box.remove('username');
              
              print('User logged out');
              
              // Navigate to login page
              NavigationUtil.toLoginIndex();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
