import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'user_page_logic.dart';

class UserPagePage extends StatefulWidget {
  const UserPagePage({super.key});

  @override
  State<UserPagePage> createState() => _UserPagePageState();
}

class _UserPagePageState extends State<UserPagePage> {
  final UserPageLogic logic = Get.put(UserPageLogic());

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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildUserInfo(),
                      _buildStats(),
                      _buildActionButtons(),
                      _buildTabs(),
                      _buildPosts(),
                    ],
                  ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Image.asset('images/back.png', width: 40, height: 40),
            onPressed: logic.onBack,
          ),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, size: 28),
            onPressed: logic.onMoreOptions,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return GetBuilder<UserPageLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Avatar
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFBBDEFB),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(l.userAvatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Name
              Text(
                l.userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              // Bio
              Text(
                l.userBio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStats() {
    return GetBuilder<UserPageLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Following', l.followingCount.toString()),
              _buildStatItem('Followers', l.followersCount.toString()),
              _buildStatItem('Friends', l.friendsCount.toString()),
              _buildStatItem('Posts', l.postsCount.toString()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return GetBuilder<UserPageLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: l.toggleFollow,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: l.isFollowing ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: l.isFollowing ? Colors.black26 : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        l.isFollowing ? 'Following' : 'Follow',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: l.isFollowing ? Colors.black54 : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: logic.onMessage,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: const Center(
                      child: Text(
                        'Message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
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

  Widget _buildTabs() {
    return GetBuilder<UserPageLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: List.generate(
              l.tabs.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => l.selectTab(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildPosts() {
    return GetBuilder<UserPageLogic>(
      builder: (l) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemCount: l.displayPosts.length,
          itemBuilder: (context, index) {
            final post = l.displayPosts[index];
            return GestureDetector(
              onTap: () => l.onPostTap(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Post image
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: post['image'] != null
                            ? Image.asset(post['image'], fit: BoxFit.cover)
                            : Container(
                                color: const Color(0xFFE1F5FE),
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.blueGrey.withOpacity(0.3),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 16,
                            color: post['liked']
                                ? Colors.red
                                : Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${post['likes']}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
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

  @override
  void dispose() {
    Get.delete<UserPageLogic>();
    super.dispose();
  }
}
