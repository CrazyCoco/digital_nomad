import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../comm/realm_service.dart';
import '../../model/post.dart';
import '../../model/user.dart';

class PostLogic extends GetxController {
  final ImagePicker _picker = ImagePicker();

  String content = '';
  int selectedTab = 0;

  final List<String> images = [];

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

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

    // 检查金币余额
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;

    if (currentUserId == null) {
      EasyLoading.showError('Please login first');
      return;
    }

    final realmService = RealmService();
    final currentUser = realmService.getUserById(currentUserId);

    if (currentUser == null) {
      EasyLoading.showError('User not found');
      return;
    }

    // 检查金币是否足够
    if (currentUser.coins < 30) {
      EasyLoading.showError(
        'Insufficient coins. You need 30 coins to post, but you only have ${currentUser.coins} coins.',
        duration: const Duration(seconds: 3),
      );
      return;
    }

    EasyLoading.show(status: 'Posting...');

    try {
      // 扣除30金币
      final updatedCoins = currentUser.coins - 30;
      final updatedUser = User(
        currentUser.id,
        currentUser.name,
        avatar: currentUser.avatar,
        bio: currentUser.bio,
        title: currentUser.title,
        gender: currentUser.gender,
        location: currentUser.location,
        following: currentUser.following,
        followers: currentUser.followers,
        friends: currentUser.friends,
        postsCount: currentUser.postsCount + 1,
        coins: updatedCoins,
        isOnline: currentUser.isOnline,
        createdAt: currentUser.createdAt,
        updatedAt: DateTime.now(),
      );

      realmService.upsertUser(updatedUser);

      // 创建并保存 Post 到 Realm 数据库
      final postId = 'post_${DateTime.now().millisecondsSinceEpoch}';
      final post = Post(
        postId,
        currentUserId,
        currentUser.name,
        userAvatar: currentUser.avatar,
        description: content,
        image: images.isNotEmpty ? images.first : null,
        isVideo: false,
        likes: 0,
        comments: 0,
        shares: 0,
        views: 0,
        isLiked: false,
        category: selectedTab == 0
            ? 'Colab'
            : selectedTab == 1
            ? 'Cafe'
            : 'Outdoor',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      realmService.createPost(post);

      print('Post created successfully: $postId');

      // 发布成功后返回
      Future.delayed(const Duration(seconds: 1), () {
        EasyLoading.dismiss();
        EasyLoading.showSuccess(
          'Post published successfully! -30 coins. Remaining: $updatedCoins coins',
        );
        Get.back();
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to post: $e');
      print('Error posting: $e');
    }
  }
}
