import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/app_routes.dart';

class CreateAccountLogic extends GetxController {
  // Page controller for step navigation
  final PageController pageController = PageController();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  // Current step (0: Mail + Password, 1: Name + Avatar)
  int currentStep = 0;

  // Form states
  String email = '';
  String password = '';
  String name = '';
  bool showPassword = false;
  String? avatarPath; // Store avatar image path

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }

  /// Pick avatar from gallery
  Future<void> pickAvatar() async {
    try {
      // Request photo library permission
      var status = await Permission.photos.status;

      // If limited access (iOS), we can still pick photos
      if (status.isLimited) {
        // Continue to picker
      } else if (!status.isGranted) {
        status = await Permission.photos.request();
        if (!status.isGranted && !status.isLimited) {
          EasyLoading.showError('Photo library permission denied');
          return;
        }
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        avatarPath = image.path;
        update();
        EasyLoading.showSuccess('Avatar selected');
      }
    } catch (e) {
      EasyLoading.showError('Failed to pick image: $e');
    }
  }

  /// Take avatar photo
  Future<void> takeAvatarPhoto() async {
    try {
      // Request camera permission
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        status = await Permission.camera.request();
        if (!status.isGranted) {
          EasyLoading.showError('Camera permission denied');
          return;
        }
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        avatarPath = image.path;
        update();
        EasyLoading.showSuccess('Photo taken');
      }
    } catch (e) {
      EasyLoading.showError('Failed to take photo: $e');
    }
  }

  /// Show avatar source dialog
  void showAvatarSourceDialog() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Choose Avatar Source'),
        message: const Text('Select how to get your avatar'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              pickAvatar();
            },
            child: const Text('Photo Library'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              takeAvatarPhoto();
            },
            child: const Text('Camera'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          isDefaultAction: true,
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }

  /// Go to next step
  void onNext() {
    // Validate current step
    if (currentStep == 0) {
      // Validate email
      if (emailController.text.isEmpty) {
        EasyLoading.showError('Please enter your email');
        return;
      }
      // Validate password
      if (passwordController.text.isEmpty) {
        EasyLoading.showError('Please enter your password');
        return;
      }
      email = emailController.text;
      password = passwordController.text;
    }

    // Move to next step
    if (currentStep < 1) {
      currentStep++;
      pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
    }
  }

  /// Create account
  void onCreateAccount() async {
    // Validate name
    if (nameController.text.isEmpty) {
      EasyLoading.showError('Please enter your name');
      return;
    }
    name = nameController.text;

    EasyLoading.show(status: 'Creating account...');

    // TODO: Call API to create account
    // Example:
    // final response = await AuthService.createAccount(
    //   email: email,
    //   password: password,
    //   name: name,
    //   avatar: avatarPath,
    // );

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Account created successfully');

      // Navigate to main page
      NavigationUtil.toMainTab();
    });
  }

  /// Go to previous step
  void onBack() {
    if (currentStep > 0) {
      currentStep--;
      pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
    } else {
      Get.back();
    }
  }
}
