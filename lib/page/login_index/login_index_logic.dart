import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginIndexLogic extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Apple Login
  Future<void> onAppleLogin() async {
    try {
      EasyLoading.show(status: 'Signing in...');

      // Generate random string as nonce
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Request Apple login
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print('Apple login successful');
      print('User ID: ${credential.userIdentifier}');
      print('Email: ${credential.email}');
      print('Given Name: ${credential.givenName}');
      print('Family Name: ${credential.familyName}');
      print('Authorization Code: ${credential.authorizationCode}');
      print('Identity Token: ${credential.identityToken}');

      EasyLoading.dismiss();
      EasyLoading.showSuccess('Login successful');

      // TODO: Send credential to backend for verification
      // TODO: Save user info and navigate to home page
      // await _handleAppleLoginSuccess(credential, rawNonce);
    } on SignInWithAppleAuthorizationException catch (e) {
      EasyLoading.dismiss();
      print('Apple login authorization exception: $e');

      // User cancelled login
      if (e.code == AuthorizationErrorCode.canceled) {
        EasyLoading.showInfo('Login cancelled');
      } else {
        EasyLoading.showError('Login failed: ${e.message}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Apple login exception: $e');
      EasyLoading.showError('Login failed, please try again');
    }
  }

  /// Generate random nonce
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// SHA256 Hash
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Create Account
  void onCreateAccount() {
    EasyLoading.showInfo('Navigate to register page');
    // TODO: Navigate to register page
    // Get.toNamed('/register');
  }

  /// Sign In
  void onSignIn() {
    EasyLoading.showInfo('Navigate to login page');
    // TODO: Navigate to login page
    // Get.toNamed('/login');
  }

  /// User Agreement
  void onUserAgreement() {
    EasyLoading.showInfo('View user agreement');
    // TODO: Open user agreement page or link
  }

  /// Privacy Policy
  void onPrivacyPolicy() {
    EasyLoading.showInfo('View privacy policy');
    // TODO: Open privacy policy page or link
  }
}
