import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

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
    
    // TODO: Call API to sign in
    // Example:
    // final response = await AuthService.signIn(
    //   email: email,
    //   password: password,
    // );
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Sign in successful');
      
      // TODO: Navigate to home page
      // Get.offAllNamed('/home');
    });
  }
  
  /// Create account
  void onCreateAccount() {
    Get.back();
    // TODO: Navigate to create account page
    // Get.toNamed('/create-account');
  }
}
