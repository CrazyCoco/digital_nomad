import 'dart:developer' as developer;

import 'package:bmob_plugin/bmob/table/bmob_user.dart';
import 'package:bmob_plugin/bmob/response/bmob_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      // Create BmobUser instance
      BmobUser bmobUser = BmobUser();
      bmobUser.username = email;
      bmobUser.password = password;
      
      // Login with Bmob
      await bmobUser.login().then((BmobUser user) {
        EasyLoading.dismiss();
        
        developer.log('Login successful');
        developer.log('User ID: ${user.getObjectId()}');
        developer.log('Username: ${user.username ?? ""}');
        
        EasyLoading.showSuccess('Sign in successful');
        
        // Save login status
        final box = GetStorage();
        box.write('is_logged_in', true);
        box.write('user_id', user.getObjectId());
        box.write('username', user.username);
        
        // Navigate to home page
        NavigationUtil.toMainTab();
      }).catchError((error) {
        EasyLoading.dismiss();
        
        final bmobError = BmobError.convert(error);
        final errorMessage = bmobError?.error ?? 'Login failed';
        
        developer.log('Login error: $errorMessage');
        
        // Show error message
        showCupertinoDialog(
          context: Get.context!,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Login Failed'),
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
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
