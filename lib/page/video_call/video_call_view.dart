import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'video_call_logic.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});
  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final VideoCallLogic logic = Get.put(VideoCallLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Main video (other person)
            Positioned.fill(
              child: Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(Icons.person, size: 150, color: Colors.white54),
                ),
              ),
            ),
            // Self video (picture in picture) - Show real camera preview
            Positioned(
              top: 60,
              right: 20,
              child: GetBuilder<VideoCallLogic>(
                builder: (l) => Container(
                  width: 120,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _buildCameraPreview(l),
                  ),
                ),
              ),
            ),
            // User info
            Positioned(
              top: 60,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    logic.userName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '00:${logic.callDuration.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            // Bottom controls
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: GetBuilder<VideoCallLogic>(
                builder: (l) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: l.isMuted ? Icons.mic_off : Icons.mic,
                      label: 'Mute',
                      isActive: l.isMuted,
                      onTap: l.toggleMute,
                    ),
                    _buildControlButton(
                      icon: l.isVideoOff ? Icons.videocam_off : Icons.videocam,
                      label: 'Video',
                      isActive: l.isVideoOff,
                      onTap: l.toggleVideo,
                    ),
                    GestureDetector(
                      onTap: l.endCall,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.call_end, size: 35, color: Colors.white),
                      ),
                    ),
                    _buildControlButton(
                      icon: l.isFrontCamera ? Icons.flip_camera_ios : Icons.flip_camera_android,
                      label: 'Switch',
                      isActive: false,
                      onTap: l.switchCamera,
                    ),
                    _buildControlButton(
                      icon: Icons.more_horiz,
                      label: 'More',
                      isActive: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isActive ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }
  
  /// Build camera preview widget
  Widget _buildCameraPreview(VideoCallLogic logic) {
    // If video is off, show placeholder
    if (logic.isVideoOff) {
      return Container(
        color: Colors.grey[800],
        child: const Center(
          child: Icon(Icons.videocam_off, size: 40, color: Colors.white54),
        ),
      );
    }
    
    // If camera is not initialized, show loading
    if (!logic.isCameraInitialized || logic.cameraController == null) {
      return Container(
        color: Colors.grey[800],
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }
    
    // Show real camera preview
    return CameraPreview(logic.cameraController!);
  }

  @override
  void dispose() {
    Get.delete<VideoCallLogic>();
    super.dispose();
  }
}
