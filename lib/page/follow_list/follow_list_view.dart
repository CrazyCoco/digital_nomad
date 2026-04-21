import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../widgets/empty_state_view.dart';

import 'follow_list_logic.dart';

class FollowListPage extends StatefulWidget {
  const FollowListPage({super.key});

  @override
  State<FollowListPage> createState() => _FollowListPageState();
}

class _FollowListPageState extends State<FollowListPage> {
  final FollowListLogic logic = Get.put(FollowListLogic());

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
          title: const Text(
            'Connections',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildTabs(),
            Expanded(
              child: GetBuilder<FollowListLogic>(
                builder: (l) {
                  if (l.selectedTab == 0) {
                    return _buildUserList(l.followingList, showFollowButton: true);
                  } else if (l.selectedTab == 1) {
                    return _buildUserList(l.followersList, showFollowButton: true);
                  } else {
                    return _buildUserList(l.friendsList, showFollowButton: false);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return GetBuilder<FollowListLogic>(
      builder: (l) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: List.generate(
              l.tabs.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => l.selectTab(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: l.selectedTab == index
                              ? const Color(0xFF42A5F5)
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      l.tabs[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: l.selectedTab == index
                            ? Colors.black
                            : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserList(List<Map<String, dynamic>> users, {required bool showFollowButton}) {
    if (users.isEmpty) {
      return EmptyStateView(message: 'No users yet');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return _buildUserCard(users[index], index, showFollowButton);
      },
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user, int index, bool showFollowButton) {
    return GetBuilder<FollowListLogic>(
      builder: (l) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationUtil.toUserPage(userName: user['name']);
                      // Refresh data when returning
                      Future.delayed(Duration.zero, () {
                        l.loadData();
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBDEFB),
                        shape: BoxShape.circle,
                        image: user['avatar'] != null
                            ? DecorationImage(
                                image: AssetImage(user['avatar']),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: user['avatar'] == null
                          ? const Icon(
                              Icons.person,
                              size: 35,
                              color: Color(0xFF2196F3),
                            )
                          : null,
                    ),
                  ),
                  if (user['online'] == true)
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
                      user['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['bio'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (showFollowButton)
                GestureDetector(
                  onTap: () => l.toggleFollow(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: user['isFollowing'] ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: user['isFollowing'] ? Colors.black26 : Colors.black,
                      ),
                    ),
                    child: Text(
                      user['isFollowing'] ? 'Following' : 'Follow',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: user['isFollowing'] ? Colors.black54 : Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<FollowListLogic>();
    super.dispose();
  }
}
