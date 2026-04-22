import 'package:digital_nomad/page/store/store_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/empty_state_view.dart';

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
          Image.asset("images/icon_102.png", width: 109),
        ],
      ),
    );
  }

  Widget _buildFriendList() {
    return GetBuilder<StoreLogic>(
      builder: (l) {
        if (l.friendsList.isEmpty) {
          return EmptyStateView(message: 'No friends yet');
        }
        
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            l.loadFriends();
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: l.friendsList.length,
            itemBuilder: (context, index) {
              final friend = l.friendsList[index];

              return Dismissible(
                key: Key(friend['id']),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Remove Friend'),
                        content: Text('Are you sure you want to remove ${friend['name']} from your friends?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              'Remove',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  l.removeFriend(index);
                },
                child: GestureDetector(
                  onTap: () => l.onChatTap(friend['name'], friend['avatar']),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(friend['avatar']),
                              backgroundColor: const Color(0xFFE1F5FE),
                              child: friend['avatar'] == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Color(0xFF2196F3),
                                    )
                                  : null,
                            ),
                            if (friend['isOnline'])
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF76FF03),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                friend['bio'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${friend['postsCount']} posts',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: Color(0xFF42A5F5),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
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
