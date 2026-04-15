import 'package:digital_nomad/page/store/store_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final StoreLogic logic = Get.put(StoreLogic());

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
            children: [
              _buildHeader(),
              Expanded(child: _buildFriendList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(
            'Friend',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFF8C42),
              shadows: [
                Shadow(
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Friend request',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendList() {
    return GetBuilder<StoreLogic>(
      builder: (l) {
        return RefreshIndicator(
          onRefresh: () async {
            // TODO: 实现实际的下拉刷新逻辑
            await Future.delayed(const Duration(seconds: 1));
            l.update();
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: l.friendRequests.length,
            itemBuilder: (context, index) {
              final request = l.friendRequests[index];
              final isLast = index == l.friendRequests.length - 1;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: const NetworkImage(
                            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=100&h=100&fit=crop',
                          ),
                          backgroundColor: const Color(0xFFE1F5FE),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Color(0xFF2196F3),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${request['unread']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
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
                            children: [
                              Text(
                                request['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: request['gender'] == 'Female'
                                      ? const Color(0xFFFF80AB)
                                      : const Color(0xFF82B1FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  request['gender'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                request['time'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            request['message'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isLast) ...[
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => l.deleteFriendRequest(index),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFEBEE),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            size: 24,
                            color: Color(0xFFFF5252),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<StoreLogic>();
    super.dispose();
  }
}
