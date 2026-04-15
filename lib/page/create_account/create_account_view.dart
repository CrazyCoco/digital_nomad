import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'create_account_logic.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final CreateAccountLogic logic = Get.put(CreateAccountLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EEF0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE8EEF0),
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(
              'images/back.png',
              width: 48,
              height: 48,
            ).marginOnly(left: 10),
            onPressed: Get.back,
          ),
          title: const Text(
            'Create account',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Page view for steps
            Expanded(
              child: GetBuilder<CreateAccountLogic>(
                builder: (logic) {
                  return PageView(
                    controller: logic.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildStep1(logic),
                      _buildStep2(logic),
                    ],
                  );
                },
              ),
            ),
            // Bottom section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Already have an account text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2196F3),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Next/Create button
                  GetBuilder<CreateAccountLogic>(
                    builder: (logic) {
                      return GestureDetector(
                        onTap: logic.currentStep < 1
                            ? logic.onNext
                            : logic.onCreateAccount,
                        child: Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(27),
                          ),
                          child: Center(
                            child: Text(
                              logic.currentStep < 1 ? 'Next' : 'Create',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Bottom safe area
                  Container(
                    width: 140,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Step 1: Email input
  Widget _buildStep1(CreateAccountLogic logic) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // Mail label
            Row(
              children: [
                const Icon(Icons.email, size: 24, color: Colors.black87),
                const SizedBox(width: 8),
                const Text(
                  'Mail',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Mail input
            TextField(
              controller: logic.emailController,
              decoration: InputDecoration(
                hintText: 'Please enter...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            // Password label
            Row(
              children: [
                const Icon(Icons.lock, size: 24, color: Colors.black87),
                const SizedBox(width: 8),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Password input
            GetBuilder<CreateAccountLogic>(
              builder: (logic) {
                return TextField(
                  controller: logic.passwordController,
                  obscureText: !logic.showPassword,
                  decoration: InputDecoration(
                    hintText: 'Please enter...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        logic.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 24,
                        color: Colors.black54,
                      ),
                      onPressed: logic.togglePasswordVisibility,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Step 2: Password input (removed, merged into Step 1)

  /// Step 2: Name and avatar
  Widget _buildStep2(CreateAccountLogic logic) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // Avatar
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: logic.showAvatarSourceDialog,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD0EBFF),
                        shape: BoxShape.circle,
                      ),
                      child: logic.avatarPath != null
                          ? ClipOval(
                              child: Image.file(
                                File(logic.avatarPath!),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 80,
                              color: Color(0xFF5DADE2),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: logic.showAvatarSourceDialog,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF34495E),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Name input
            TextField(
              controller: logic.nameController,
              decoration: InputDecoration(
                hintText: 'Halle Berry',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<CreateAccountLogic>();
    super.dispose();
  }
}
