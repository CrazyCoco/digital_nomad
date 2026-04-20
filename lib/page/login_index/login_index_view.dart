import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'login_index_logic.dart';

class LoginIndexPage extends StatefulWidget {
  const LoginIndexPage({super.key});

  @override
  State<LoginIndexPage> createState() => _LoginIndexPageState();
}

class _LoginIndexPageState extends State<LoginIndexPage> {
  final LoginIndexLogic logic = Get.put(LoginIndexLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color(0xFFB3E5FC),
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x00A3D3F0), Color(0xFFA3D3F0)],
            ),
          ),
          child: Stack(
            children: [
              Image.asset(
                'images/login_index_bg.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  // 顶部间距
                  const SizedBox(height: 40),
                  const Spacer(),
                  // 按钮区域
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        // Sign in with Apple 按钮
                        _buildAppleLoginButton(),
                        const SizedBox(height: 12),
                        // Create account 按钮
                        _buildWhiteButton(
                          text: 'Create account',
                          onPressed: logic.onCreateAccount,
                        ),
                        const SizedBox(height: 12),
                        // Sign in 按钮
                        _buildWhiteButton(
                          text: 'Sign in',
                          onPressed: logic.onSignIn,
                        ),
                        const SizedBox(height: 24),
                        // 底部协议文字 - 使用 RichText 富文本
                        _buildAgreementText(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建 Apple 登录按钮
  Widget _buildAppleLoginButton() {
    return GestureDetector(
      onTap: logic.onAppleLogin,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/login_index_apple.png',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            const Text(
              'Sign in with Apple',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建白色按钮
  Widget _buildWhiteButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(27),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
      ),
    );
  }

  // 构建底部协议文字 - RichText 富文本
  Widget _buildAgreementText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 11, color: Color(0xFF78909C)),
        children: [
          const TextSpan(text: 'By signing up, you agree to the '),
          TextSpan(
            text: 'User Agreement',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF2196F3),
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = logic.onUserAgreement,
          ),
          const TextSpan(text: ' & '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF2196F3),
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = logic.onPrivacyPolicy,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<LoginIndexLogic>();
    super.dispose();
  }
}
