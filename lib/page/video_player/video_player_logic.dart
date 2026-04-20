import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../routes/app_routes.dart';

class VideoPlayerLogic extends GetxController {
  late VideoPlayerController controller;
  String videoPath = '';
  bool isInitialized = false;
  
  // Video info
  String userName = 'User';
  String userAvatar = '';
  String description = '';
  int likes = 0;
  bool isLiked = false;
  String time = '';
  
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      videoPath = arguments['videoPath'] ?? '';
      userName = arguments['userName'] ?? 'User';
      userAvatar = arguments['userAvatar'] ?? '';
      description = arguments['description'] ?? '';
      likes = arguments['likes'] ?? 0;
      isLiked = arguments['isLiked'] ?? false;
      time = arguments['time'] ?? '';
      
      if (videoPath.isNotEmpty) {
        initializeVideo();
      }
    }
  }
  
  void initializeVideo() {
    controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        isInitialized = true;
        update();
        // Auto play
        controller.play();
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }
  
  void togglePlayPause() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    update();
  }
  
  void seekTo(Duration position) {
    controller.seekTo(position);
  }
  
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
  
  void toggleLike() {
    isLiked = !isLiked;
    if (isLiked) {
      likes++;
    } else {
      likes--;
    }
    update();
  }
  
  void onReport() {
    NavigationUtil.toReport(
      reportedType: 'video',
      reportedUserName: userName,
      reportedContent: description,
    );
  }
  
  void onUserTap() {
    // TODO: Navigate to user profile
    Get.back();
  }
  
  void onBack() {
    Get.back();
  }
  
  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
