import 'package:digital_nomad/page/chat/chat_logic.dart';
import 'package:digital_nomad/widgets/empty_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../model/chat_room.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final ChatLogic logic = Get.put(ChatLogic());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Get.delete<ChatLogic>();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh chat list when app resumes
      logic.loadPrivateChats();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh when page becomes visible again
    logic.loadPrivateChats();
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildTabs(),
              Expanded(
                child: GetBuilder<ChatLogic>(
                  builder: (l) => l.selectedTab == 0
                      ? _buildPrivateChatsList()
                      : _buildRoomsGrid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Text(
        'Nomad Chat',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFFF8C42),
          shadows: [
            Shadow(
              offset: const Offset(2, 2),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return GetBuilder<ChatLogic>(
      builder: (l) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: List.generate(l.tabs.length, (index) {
            final isSelected = l.selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => l.selectTab(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      l.tabs[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPrivateChatsList() {
    return GetBuilder<ChatLogic>(
      builder: (l) {
        if (l.privateChats.isEmpty) {
          return EmptyStateView(message: 'No private chats yet');
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: l.privateChats.length,
          itemBuilder: (context, index) {
            final chat = l.privateChats[index];
            return GestureDetector(
            onTap: () => l.openPrivateChat(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFFBBDEFB),
                          shape: BoxShape.circle,
                          image: chat.userAvatar != null && chat.userAvatar!.isNotEmpty
                              ? DecorationImage(
                                  image: AssetImage(chat.userAvatar!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: (chat.userAvatar == null || chat.userAvatar!.isEmpty)
                            ? const Icon(
                                Icons.person,
                                size: 32,
                                color: Color(0xFF2196F3),
                              )
                            : null,
                      ),
                      if (chat.isOnline)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chat.userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatTime(chat.lastMessageTime),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                chat.lastMessage ?? 'No messages yet',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (chat.unreadCount > 0)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${chat.unreadCount}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          },
        );
      },
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
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }

  Widget _buildRoomsGrid() {
    return GetBuilder<ChatLogic>(
      builder: (l) {
        if (l.chatRooms.isEmpty) {
          return EmptyStateView(message: 'No chat rooms available');
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: l.chatRooms.length,
          itemBuilder: (context, index) {
            return _buildChatRoom(l.chatRooms[index], index);
          },
        );
      },
    );
  }

  Widget _buildChatRoom(ChatRoom room, int index) {
    // Random image from local images
    final randomImages = [
      'images/8952cc30813886ec84178206d8877d23.jpg',
      'images/948f9b32fa7f2957bc82ec3100b057aa.jpg',
      'images/afc548276bf301d627730fb09e06be7f.jpg',
      'images/094de2a3d0f251804bbdf971c36c97ad.jpg',
      'images/16dcb0bf7d0f122690c0b0e1916494d4.jpg',
      'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
      'images/799ddffd8fbda40cd47b3d6887ed2d6c.jpg',
      'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
      'images/bf96945afb419442511807418b87dc16.jpg',
    ];
    final backgroundImage = randomImages[index % randomImages.length];
    
    return GestureDetector(
      onTap: () => logic.joinRoomChat(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            // Dark overlay for better text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            // Hot label
            if (room.isHot)
              Positioned(
                top: 12,
                left: 12,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8C42),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Hot',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFFF8C42),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            // Bottom content
            Positioned(
              bottom: 16,
              left: 12,
              right: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Room name
                  Text(
                    room.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Join button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBDEFB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Join',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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


}
