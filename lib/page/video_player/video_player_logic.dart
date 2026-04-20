import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerLogic extends GetxController {
  late VideoPlayerController controller;
  String videoPath = '';
  bool isInitialized = false;
  
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments['videoPath'] != null) {
      videoPath = arguments['videoPath'];
      initializeVideo();
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
  
  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
