import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/chat_message.dart';
import '../../routes/app_routes.dart';
import '../../widgets/empty_state_view.dart';
import 'room_chat_logic.dart';

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({super.key});

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  final RoomChatLogic logic = Get.put(RoomChatLogic());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['roomName'] != null) {
      logic.initialize(args['roomName']);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'images/8952cc30813886ec84178206d8877d23.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Dark overlay
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
            // Content
            SafeArea(
              child: Column(
                children: [
                  // Top bar
                  _buildTopBar(),
                  // Chat area
                  _buildChatArea(),
                  // Bottom input
                  _buildBottomInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
              onPressed: logic.onBack,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.white, size: 24),
              onPressed: _showRoomOptions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomInfoCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                logic.roomName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // User avatars
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Positioned(
                        left: i * 16.0,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'images/head_${i + 1}.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 20),
                // Members count
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${logic.membersCount}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatArea() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: GetBuilder<RoomChatLogic>(
          builder: (l) {
            // Return appropriate widget based on message count
            if (l.messages.isEmpty) {
              return Center(
                child: Text(
                  'No messages yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: l.messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final msg = l.messages[index];
                final isMe = msg.senderId == currentUserId;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: isMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Other user's avatar (left side)
                      if (!isMe)
                        Container(
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: _buildAvatar(msg.senderAvatar, index),
                          ),
                        ),
                      // Message bubble and timestamp
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            // Message bubble
                            GestureDetector(
                              onLongPress: () => _showMessageOptions(msg),
                              child: _buildMessageBubble(msg, isMe, context),
                            ),
                            // Timestamp
                            const SizedBox(height: 4),
                            Text(
                              _formatMessageTime(msg.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // My avatar (right side)
                      if (isMe)
                        Container(
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: _buildAvatar(msg.senderAvatar, index),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.image, color: Colors.white, size: 24),
              onPressed: logic.pickAndSendImage,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFBBDEFB), width: 2),
              ),
              child: TextField(
                controller: logic.messageController,
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
                onSubmitted: (_) => logic.sendMessage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Format DateTime to readable string (HH:mmAM/PM format)
  String _formatMessageTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '${hour.toString().padLeft(2, '0')}:${minute}$amPm';
  }

  /// Build avatar image from senderAvatar or fallback to default
  Widget _buildAvatar(String? avatarPath, int index) {
    // If avatar path exists and is a local asset
    if (avatarPath != null && avatarPath.isNotEmpty) {
      if (avatarPath.startsWith('images/')) {
        return Image.asset(avatarPath, fit: BoxFit.cover);
      } else {
        // Network image
        return Image.network(avatarPath, fit: BoxFit.cover);
      }
    }

    // Fallback to default avatar based on index
    final fallbackIndex = (index % 5) + 1;
    return Image.asset('images/head_$fallbackIndex.jpg', fit: BoxFit.cover);
  }

  /// Build message bubble (text or image)
  Widget _buildMessageBubble(ChatMessage msg, bool isMe, BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.7;

    // Check if this is an image message
    if (msg.messageType == 1 &&
        msg.imageUrl != null &&
        msg.imageUrl!.isNotEmpty) {
      // Image message
      return Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFBBDEFB) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
          child: _buildImageMessage(msg.imageUrl!, maxWidth),
        ),
      );
    }

    // Text message (default)
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFFBBDEFB) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isMe ? 16 : 4),
          bottomRight: Radius.circular(isMe ? 4 : 16),
        ),
      ),
      child: Text(
        msg.content,
        style: TextStyle(
          fontSize: 15,
          color: isMe ? Colors.black87 : Colors.black,
        ),
      ),
    );
  }

  /// Build image message widget
  Widget _buildImageMessage(String imagePath, double maxWidth) {
    // Check if it's a local file
    if (imagePath.startsWith('/') || imagePath.contains('file://')) {
      // Local file image
      return Image.file(
        File(imagePath.replaceFirst('file://', '')),
        fit: BoxFit.cover,
        width: maxWidth,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: maxWidth,
            height: 100,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          );
        },
      );
    } else if (imagePath.startsWith('http://') ||
        imagePath.startsWith('https://')) {
      // Network image
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: maxWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: maxWidth,
            height: 100,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: maxWidth,
            height: 100,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          );
        },
      );
    } else {
      // Asset image
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: maxWidth,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: maxWidth,
            height: 100,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          );
        },
      );
    }
  }

  /// Show message options menu (Report)
  void _showMessageOptions(ChatMessage message) {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    final isMe = message.senderId == currentUserId;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            if (!isMe)
              ListTile(
                leading: const Icon(Icons.flag, color: Colors.red),
                title: const Text(
                  'Report Message',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Get.back();
                  logic.onReportMessage(message);
                },
              ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.blue),
              title: const Text(
                'Copy Message',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Get.back();
                // TODO: Copy message to clipboard
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Show room options menu (Report Room)
  void _showRoomOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.flag, color: Colors.red),
              title: const Text(
                'Report Room',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Report ${logic.roomName} for inappropriate content',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              onTap: () {
                Get.back();
                _reportRoom();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Report the current room
  void _reportRoom() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;

    if (currentUserId == null) return;

    // Get reporter info
    final currentUser = logic.getReporterInfo();

    NavigationUtil.toReport(
      reportedType: 'room',
      reportedUserName: logic.roomName,
      reportedContent: 'Chat Room: ${logic.roomName}',
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.delete<RoomChatLogic>();
    super.dispose();
  }
}
