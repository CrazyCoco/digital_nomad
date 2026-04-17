import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    print('View privacy policy');
  }
  
  void onTermsOfService() {
    print('View terms of service');
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
              // TODO: Clear user data and navigate to login
              print('Logout');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
