import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../widgets/empty_state_view.dart';
import 'private_chat_logic.dart';

class PrivateChatPage extends StatefulWidget {
  const PrivateChatPage({super.key});

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final PrivateChatLogic logic = Get.put(PrivateChatLogic());

  @override
  void initState() {
    super.initState();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      logic.initialize(
        args['userName'] ?? 'User',
        args['userAvatar'] ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EEF0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE8EEF0),
          elevation: 0,
          leading: IconButton(
            icon: Image.asset('images/back.png', width: 40, height: 40),
            onPressed: logic.onBack,
          ),
          title: Row(
            children: [
              GetBuilder<PrivateChatLogic>(
                builder: (l) => Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBBDEFB),
                    shape: BoxShape.circle,
                    image: l.userAvatar.isNotEmpty
                        ? DecorationImage(
                            image: AssetImage(l.userAvatar),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: l.userAvatar.isEmpty
                      ? const Icon(Icons.person, size: 24, color: Color(0xFF2196F3))
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              GetBuilder<PrivateChatLogic>(
                builder: (l) => Text(
                  l.userName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            // Video call button
            GetBuilder<PrivateChatLogic>(
              builder: (l) => IconButton(
                icon: const Icon(Icons.videocam, color: Colors.black),
                onPressed: l.startVideoCall,
              ),
            ),
            // More options button
            GetBuilder<PrivateChatLogic>(
              builder: (l) => IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                onPressed: l.showOptionsMenu,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: GetBuilder<PrivateChatLogic>(
                builder: (l) {
                  if (l.messages.isEmpty) {
                    return EmptyStateView(message: 'No messages yet');
                  }
                  
                  // Get current user ID to determine isMe
                  final box = GetStorage();
                  final currentUserId = box.read('user_id') as String?;
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: l.messages.length,
                    itemBuilder: (context, index) {
                      final msg = l.messages[index];
                      final isMe = msg.senderId == currentUserId;
                      
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                Text(
                                  msg.senderName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2196F3),
                                  ),
                                ),
                              const SizedBox(height: 4),
                              Text(
                                msg.content,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isMe ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTime(msg.createdAt),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isMe ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: logic.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: const Color(0xFFE8EEF0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => logic.sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: logic.sendMessage,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Format DateTime to readable string
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.month}/${dateTime.day} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  void dispose() {
    Get.delete<PrivateChatLogic>();
    super.dispose();
  }
}
