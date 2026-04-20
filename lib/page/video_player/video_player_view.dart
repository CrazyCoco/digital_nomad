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
        body: GetBuilder<VideoPlayerLogic>(
          builder: (l) {
            if (!l.isInitialized) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            return Stack(
              children: [
                // Video player - full screen
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: l.controller.value.size.width,
                      height: l.controller.value.size.height,
                      child: VideoPlayer(l.controller),
                    ),
                  ),
                ),

                // Play/Pause overlay
                Positioned.fill(
                  child: GestureDetector(
                    onTap: l.togglePlayPause,
                    child: AnimatedOpacity(
                      opacity: l.controller.value.isPlaying ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            l.controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Top bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          GestureDetector(
                            onTap: l.onBack,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1C1C1E),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          // Weather icon
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.wb_sunny,
                              color: Color(0xFFFF9800),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Right side actions
                Positioned(
                  right: 16,
                  bottom: 160,
                  child: Column(
                    children: [
                      // Like button
                      GestureDetector(
                        onTap: l.toggleLike,
                        child: Column(
                          children: [
                            Icon(
                              l.isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 40,
                              color: l.isLiked ? Colors.red : Colors.white,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${l.likes}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Report button
                      GestureDetector(
                        onTap: l.onReport,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom info
                Positioned(
                  left: 16,
                  right: 80,
                  bottom: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User info
                      Row(
                        children: [
                          // User avatar
                          GestureDetector(
                            onTap: l.onUserTap,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xFFBBDEFB),
                              backgroundImage: l.userAvatar.isNotEmpty
                                  ? AssetImage(l.userAvatar)
                                  : null,
                              child: l.userAvatar.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      size: 24,
                                      color: Color(0xFF2196F3),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.userName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (l.time.isNotEmpty)
                                Text(
                                  l.time,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Description
                      if (l.description.isNotEmpty)
                        Text(
                          l.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
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
