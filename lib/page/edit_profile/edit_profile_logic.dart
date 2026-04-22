import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../comm/realm_service.dart';
import '../../model/user.dart';

class EditProfileLogic extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final RealmService _realmService = RealmService();
  
  // 用户信息
  String currentUserId = '';
  String avatarPath = '';
  String userName = '';
  String userBio = '';
  String userTitle = ''; // 头衔
  String gender = 'Male';
  String location = '';
  
  // 控制器
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }
  
  /// Load current user data from Realm
  void loadCurrentUser() {
    final box = GetStorage();
    final userId = box.read('user_id') as String?;
    
    if (userId != null) {
      currentUserId = userId;
      final user = _realmService.getUserById(userId);
      
      if (user != null) {
        userName = user.name;
        userBio = user.bio ?? '';
        userTitle = user.title ?? ''; // 加载头衔
        gender = user.gender ?? 'Male';
        location = user.location ?? '';
        avatarPath = user.avatar ?? '';
        
        // Update controllers
        nameController.text = userName;
        bioController.text = userBio;
        locationController.text = location;
        
        update();
      }
    }
  }
  
  Future<void> pickImageFromGallery() async {
    try {
      // Request photo library permission
      var status = await Permission.photos.status;
      
      if (status.isDenied || status.isPermanentlyDenied) {
        status = await Permission.photos.request();
      }
      
      if (status.isGranted || status.isLimited) {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          avatarPath = image.path;
          update();
        }
      } else {
        showPermissionDeniedDialog('Photo Library');
      }
    } catch (e) {
      print('Error picking image: $e');
      EasyLoading.showError('Failed to pick image');
    }
  }
  
  Future<void> pickImageFromCamera() async {
    try {
      // Request camera permission
      var status = await Permission.camera.status;
      
      if (status.isDenied || status.isPermanentlyDenied) {
        status = await Permission.camera.request();
      }
      
      if (status.isGranted) {
        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          avatarPath = image.path;
          update();
        }
      } else {
        showPermissionDeniedDialog('Camera');
      }
    } catch (e) {
      print('Error taking photo: $e');
      EasyLoading.showError('Failed to take photo');
    }
  }
  
  void showPermissionDeniedDialog(String permissionName) {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Permission Required'),
        content: Text('Please enable $permissionName permission in Settings'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Open Settings'),
            onPressed: () {
              Get.back();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }
  
  void showAvatarSourceDialog() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Select Avatar'),
        message: const Text('Choose how to get your avatar'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              pickImageFromGallery();
            },
            child: const Text('Photo Library'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              pickImageFromCamera();
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
  
  void onSave() async {
    if (currentUserId.isEmpty) {
      EasyLoading.showError('User not logged in');
      return;
    }
    
    final newName = nameController.text.trim();
    if (newName.isEmpty) {
      EasyLoading.showError('Name cannot be empty');
      return;
    }
    
    EasyLoading.show(status: 'Saving...');
    
    try {
      final user = _realmService.getUserById(currentUserId);
      
      if (user != null) {
        // Update user fields directly
        _realmService.upsertUser(
          User(
            currentUserId,
            newName,
            avatar: avatarPath.isNotEmpty ? avatarPath : user.avatar,
            bio: bioController.text.trim(),
            title: userTitle, // 保存头衔
            gender: gender,
            location: locationController.text.trim(),
            following: user.following,
            followers: user.followers,
            friends: user.friends,
            postsCount: user.postsCount,
            isOnline: user.isOnline,
            createdAt: user.createdAt,
            updatedAt: DateTime.now(),
          ),
        );
        
        EasyLoading.showSuccess('Profile updated successfully');
        
        // Navigate back after a short delay
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back(result: true); // Return true to indicate success
      } else {
        EasyLoading.showError('User not found');
      }
    } catch (e) {
      print('Error saving profile: $e');
      EasyLoading.showError('Failed to save profile');
    }
  }
  
  void onBack() {
    Get.back();
  }
  
  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
