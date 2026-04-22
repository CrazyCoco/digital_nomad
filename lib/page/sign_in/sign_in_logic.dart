import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/data_initializer.dart';
import '../../comm/realm_service.dart';
import '../../routes/app_routes.dart';

class SignInLogic extends GetxController {
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Form states
  String email = '';
  String password = '';
  bool showPassword = false;
  
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  
  /// Toggle password visibility
  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }
  
  /// Sign in
  void onSignIn() async {
    // Validate form
    if (emailController.text.isEmpty) {
      EasyLoading.showError('Please enter your email');
      return;
    }
    
    if (passwordController.text.isEmpty) {
      EasyLoading.showError('Please enter your password');
      return;
    }
    
    EasyLoading.show(status: 'Signing in...');
    
    email = emailController.text;
    password = passwordController.text;
    
    try {
      // Simple validation for demo account
      // In production, this should be replaced with proper authentication
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (email == '123456@ss.com' && password == '1234567890') {
        // Login successful with demo account
        EasyLoading.dismiss();
        
        developer.log('Login successful');
        developer.log('Email: $email');
        
        EasyLoading.showSuccess('Sign in successful');
        
        // Save login status
        final box = GetStorage();
        box.write('is_logged_in', true);
        box.write('user_email', email);
        
        // Get user from Realm database
        final realmService = RealmService();
        final users = realmService.getAllUsers();
        
        // Use first user as current user (Alice Johnson)
        if (users.isNotEmpty) {
          final currentUser = users.first;
          box.write('user_id', currentUser.id);
          box.write('username', currentUser.name);
          
          developer.log('Current user: ${currentUser.name}');
        }
        
        // Ensure seed data is initialized after login
        developer.log('Ensuring seed data is initialized...');
        DataInitializer.initializeSeedData();
        
        // Navigate to home page
        NavigationUtil.toMainTab();
      } else {
        // Invalid credentials
        EasyLoading.dismiss();
        
        developer.log('Login failed: Invalid credentials');
        
        // Show error message
        showCupertinoDialog(
          context: Get.context!,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid email or password.\n\nDemo Account:\nEmail: 123456@ss.com\nPassword: 1234567890'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      developer.log('Exception: $e');
      
      showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text('An unexpected error occurred: $e'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  
  /// Create account
  void onCreateAccount() {
    Get.back();
    NavigationUtil.toCreateAccount();
  }
}
