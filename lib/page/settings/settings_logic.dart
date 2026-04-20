import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_routes.dart';

class SettingsLogic extends GetxController {
  String language = 'English';
  
  void onBack() => Get.back();
  
  void onEditProfile() {
    NavigationUtil.toEditProfile();
  }
  
  void onPrivacyPolicy() {
    NavigationUtil.toPrivacyPolicy();
  }
  
  void onTermsOfService() {
    NavigationUtil.toTermsOfService();
  }
  
  void onHelpCenter() {
    // TODO: Navigate to help center
    Get.snackbar(
      'Help Center',
      'Coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void onAboutUs() {
    // TODO: Navigate to about us
    Get.snackbar(
      'About Us',
      'Version 1.0.0\nDigital Nomad App',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void onRateApp() {
    // TODO: Open app store
    Get.snackbar(
      'Rate App',
      'Thank you for your support!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void onShareApp() {
    // TODO: Share app
    Get.snackbar(
      'Share App',
      'Share feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
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
