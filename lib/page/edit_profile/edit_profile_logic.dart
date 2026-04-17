import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileLogic extends GetxController {
  final ImagePicker _picker = ImagePicker();
  
  // 用户信息
  String avatarPath = '';
  String userName = 'John Doe';
  String userBio = 'Digital nomad | Travel enthusiast | Coffee lover';
  String gender = 'Male';
  String location = 'San Francisco, CA';
  
  // 控制器
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    nameController.text = userName;
    bioController.text = userBio;
    locationController.text = location;
  }
  
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        avatarPath = image.path;
        update();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        avatarPath = image.path;
        update();
      }
    } catch (e) {
      print('Error taking photo: $e');
    }
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
  
  void onSave() {
    userName = nameController.text;
    userBio = bioController.text;
    location = locationController.text;
    
    // TODO: Save to backend
    print('Saving profile...');
    print('Name: $userName');
    print('Bio: $userBio');
    print('Location: $location');
    print('Avatar: $avatarPath');
    
    Get.back();
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
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
