import 'package:get/get.dart';

class VideoCallLogic extends GetxController {
  String userName = 'Alice Johnson';
  bool isMuted = false;
  bool isVideoOff = false;
  bool isFrontCamera = true;
  int callDuration = 0;
  
  void toggleMute() {
    isMuted = !isMuted;
    update();
  }
  
  void toggleVideo() {
    isVideoOff = !isVideoOff;
    update();
  }
  
  void switchCamera() {
    isFrontCamera = !isFrontCamera;
    update();
  }
  
  void endCall() {
    Get.back();
  }
  
  void onBack() => Get.back();
}
