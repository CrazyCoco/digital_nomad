import 'dart:async';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class VideoCallLogic extends GetxController {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  
  String userName = 'User';
  bool isMuted = false;
  bool isVideoOff = false;
  bool isFrontCamera = true;
  int callDuration = 0;
  bool isCameraInitialized = false;
  
  CameraController? get cameraController => _cameraController;
  
  @override
  void onInit() {
    super.onInit();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['userName'] != null) {
      userName = args['userName'];
    }
    
    // Initialize camera
    _initializeCamera();
    
    // Start call duration timer
    _startCallTimer();
  }
  
  /// Initialize camera
  Future<void> _initializeCamera() async {
    try {
      // Get available cameras
      _cameras = await availableCameras();
      
      if (_cameras.isEmpty) {
        print('No cameras available');
        return;
      }
      
      // Use front camera by default
      final camera = _cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );
      
      // Create camera controller
      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false, // We don't need audio for preview
      );
      
      // Initialize the camera
      await _cameraController!.initialize();
      
      isCameraInitialized = true;
      update();
      
      print('Camera initialized successfully');
    } catch (e) {
      print('Error initializing camera: $e');
      isCameraInitialized = false;
      update();
    }
  }
  
  /// Start call duration timer
  void _startCallTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      callDuration++;
      update();
    });
  }
  
  void toggleMute() {
    isMuted = !isMuted;
    update();
  }
  
  void toggleVideo() {
    isVideoOff = !isVideoOff;
    
    // Pause/Resume camera preview
    if (isVideoOff) {
      _cameraController?.pausePreview();
    } else {
      _cameraController?.resumePreview();
    }
    
    update();
  }
  
  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    
    try {
      isFrontCamera = !isFrontCamera;
      
      // Dispose current controller
      await _cameraController?.dispose();
      
      // Get the other camera
      final newCamera = isFrontCamera
          ? _cameras.firstWhere(
              (cam) => cam.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first,
            )
          : _cameras.firstWhere(
              (cam) => cam.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.last,
            );
      
      // Create new controller
      _cameraController = CameraController(
        newCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      
      await _cameraController!.initialize();
      
      // If video is off, pause preview
      if (isVideoOff) {
        await _cameraController!.pausePreview();
      }
      
      update();
      print('Camera switched successfully');
    } catch (e) {
      print('Error switching camera: $e');
    }
  }
  
  void endCall() {
    Get.back();
  }
  
  void onBack() => Get.back();
  
  @override
  void onClose() {
    // Dispose camera controller
    _cameraController?.dispose();
    super.onClose();
  }
}
