import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PostLogic extends GetxController {
  final ImagePicker _picker = ImagePicker();
  
  String content = '';
  int selectedTab = 0;
  
  final List<String> images = [];
  
  @override
  void onReady() { super.onReady(); }
  @override
  void onClose() { super.onClose(); }
  
  void updateContent(String value) {
    content = value;
    update();
  }
  
  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
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

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        images.add(image.path);
        update();
        EasyLoading.showSuccess('Image added');
      }
    } catch (e) {
      EasyLoading.showError('Failed to pick image: $e');
    }
  }
  
  /// Take photo from camera
  Future<void> takePhoto() async {
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

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      
      if (image != null) {
        images.add(image.path);
        update();
        EasyLoading.showSuccess('Photo added');
      }
    } catch (e) {
      EasyLoading.showError('Failed to take photo: $e');
    }
  }
  
  /// Show image source dialog
  void showImageSourceDialog() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Add Image'),
        message: const Text('Choose how to add an image'),
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
              takePhoto();
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
  
  void addImage() {
    showImageSourceDialog();
  }
  
  void removeImage(int index) {
    images.removeAt(index);
    update();
  }
  
  void selectTab(int index) { 
    selectedTab = index;
    update();
  }
  
  void post() {
    if (content.isEmpty && images.isEmpty) {
      EasyLoading.showError('Please add content or images');
      return;
    }
    
    EasyLoading.show(status: 'Posting...');
    
    // TODO: Implement post logic with backend
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Post published successfully');
      Get.back();
    });
  }
}
