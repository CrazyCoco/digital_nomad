import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'video_player_logic.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final VideoPlayerLogic logic = Get.put(VideoPlayerLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Video player
              Center(
                child: GetBuilder<VideoPlayerLogic>(
                  builder: (l) {
                    if (!l.isInitialized) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    return AspectRatio(
                      aspectRatio: l.controller.value.aspectRatio,
                      child: VideoPlayer(l.controller),
                    );
                  },
                ),
              ),
              
              // Play/Pause overlay
              Positioned.fill(
                child: GestureDetector(
                  onTap: logic.togglePlayPause,
                  child: GetBuilder<VideoPlayerLogic>(
                    builder: (l) {
                      if (!l.isInitialized) return const SizedBox();
                      return AnimatedOpacity(
                        opacity: l.controller.value.isPlaying ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: Center(
                            child: Icon(
                              l.controller.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              size: 80,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // Top bar with back button
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom controls
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GetBuilder<VideoPlayerLogic>(
                  builder: (l) {
                    if (!l.isInitialized) return const SizedBox();
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Progress bar
                          VideoProgressIndicator(
                            l.controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              playedColor: Color(0xFF42A5F5),
                              bufferedColor: Colors.white30,
                              backgroundColor: Colors.white12,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          
                          // Time and duration
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l.formatDuration(l.controller.value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  l.formatDuration(l.controller.value.duration),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<VideoPlayerLogic>();
    super.dispose();
  }
}
