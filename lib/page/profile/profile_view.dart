import 'package:digital_nomad/page/profile/profile_logic.dart';
import 'package:digital_nomad/widgets/empty_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileLogic logic = Get.put(ProfileLogic());

  /// Format user ID to numeric display
  String _formatUserId(String userId) {
    return logic.formatUserId(userId);
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
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileInfo(),
                      const SizedBox(height: 20),
                      _buildStats(),
                      const SizedBox(height: 20),
                      _buildRechargeButton(),
                      const SizedBox(height: 20),
                      _buildMenuList(),
                      const SizedBox(height: 20),
                      _buildContentTabs(),
                      const SizedBox(height: 16),
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
          Text(
            'Profile',
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
          const Icon(Icons.grid_view, size: 28, color: Color(0xFF42A5F5)),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return GetBuilder<ProfileLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFFBBDEFB),
                backgroundImage: l.currentUserAvatar.startsWith('images/')
                    ? AssetImage(l.currentUserAvatar) as ImageProvider
                    : (l.currentUserAvatar.isNotEmpty
                        ? NetworkImage(l.currentUserAvatar)
                        : const AssetImage('images/head_1.jpg')),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l.currentUserName,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (l.currentUserTitle.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB74D),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              l.currentUserTitle,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      'ID ${_formatUserId(l.currentUserId)}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: logic.onEditProfile,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit, size: 16, color: Colors.black54),
                      SizedBox(width: 4),
                      Text('Edit Profile', style: TextStyle(fontSize: 14, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStats() {
    return GetBuilder<ProfileLogic>(
      builder: (l) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: l.onFollowing,
                child: _StatItem(
                  count: '${l.followingCount}',
                  label: 'Following',
                ),
              ),
              GestureDetector(
                onTap: l.onFollowers,
                child: _StatItem(
                  count: '${l.followersCount}',
                  label: 'Followers',
                ),
              ),
              GestureDetector(
                onTap: l.onFriends,
                child: _StatItem(
                  count: '${l.friendsCount}',
                  label: 'Friends',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRechargeButton() {
    return GestureDetector(
      onTap: logic.onRecharge,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFB74D),
          borderRadius: BorderRadius.circular(27),
        ),
        child: Row(
          children: [
            const Text(
              'Recharge coins',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const Spacer(),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: const Icon(Icons.star, size: 28, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    return GetBuilder<ProfileLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildMenuItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: logic.onSettings,
              ),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.person_add,
                title: 'Friend Requests',
                onTap: logic.onFriendRequests,
                showBadge: true,
                badgeCount: l.friendRequestCount,
              ),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.block,
                title: 'Blacklist',
                onTap: logic.onBlacklist,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showBadge = false,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            if (showBadge && badgeCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            if (showBadge) const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 24, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Widget _buildContentTabs() {
    return GetBuilder<ProfileLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => l.selectContentTab(0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: l.contentTab == 0 ? const Color(0xFF42A5F5) : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    'Video(${l.videos.length})',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: l.contentTab == 0 ? Colors.black : Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              GestureDetector(
                onTap: () => l.selectContentTab(1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: l.contentTab == 1 ? const Color(0xFF42A5F5) : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    'Photo(${l.posts.length})',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: l.contentTab == 1 ? Colors.black : Colors.black54,
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

  Widget _buildPosts() {
    return GetBuilder<ProfileLogic>(
      builder: (l) {
        if (l.contentTab == 0) {
          // Video tab
          return _buildVideoList();
        } else {
          // Photo tab
          return _buildPhotoList();
        }
      },
    );
  }

  Widget _buildVideoList() {
    return GetBuilder<ProfileLogic>(
      builder: (l) {
        if (l.videos.isEmpty) {
          return EmptyStateView(message: 'No videos available');
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: l.videos.length,
          itemBuilder: (context, index) {
            final video = l.videos[index];
            return GestureDetector(
              onTap: () => l.onVideoTap(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail with play button
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: video['thumbnail'] != null &&
                                  (video['thumbnail'] as String).isNotEmpty
                              ? (video['thumbnail'] as String).startsWith('images/')
                                  ? Image.asset(
                                      video['thumbnail'],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      video['thumbnail'],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: double.infinity,
                                          height: 200,
                                          color: const Color(0xFFE1F5FE),
                                          child: const Center(
                                            child: Icon(Icons.videocam,
                                                size: 40, color: Color(0xFF90CAF9)),
                                          ),
                                        );
                                      },
                                    )
                              : Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: const Color(0xFFE1F5FE),
                                  child: const Center(
                                    child: Icon(Icons.videocam,
                                        size: 40, color: Color(0xFF90CAF9)),
                                  ),
                                ),
                        ),
                        // Play button overlay
                        Positioned.fill(
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Duration badge
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              video['duration'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Video info
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                size: 14,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                video['views'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                video['time'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
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

  Widget _buildPhotoList() {
    return GetBuilder<ProfileLogic>(
      builder: (l) {
        if (l.posts.isEmpty) {
          return EmptyStateView(message: 'No posts available');
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: l.posts.length,
          itemBuilder: (context, index) {
            final post = l.posts[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => l.onPostAuthorTap(index),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xFFBBDEFB),
                          backgroundImage: post['avatar'] != null &&
                                  (post['avatar'] as String).startsWith('images/')
                              ? AssetImage(post['avatar']) as ImageProvider
                              : (post['avatar'] != null &&
                                      (post['avatar'] as String).isNotEmpty
                                  ? NetworkImage(post['avatar'])
                                  : const AssetImage('images/head_1.jpg')),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['user'] ?? 'User',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            post['time'] ?? '',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Post content
                  Text(
                    post['content'] ?? '',
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black87, height: 1.5),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Post image
                  if (post['image'] != null && (post['image'] as String).isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        post['image'],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: const Color(0xFFE1F5FE),
                            child: const Center(
                              child:
                                  Icon(Icons.image, size: 40, color: Color(0xFF90CAF9)),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 12),
                  // Stats
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.remove_red_eye,
                              size: 16, color: Colors.black54),
                          const SizedBox(width: 4),
                          Text(
                            post['views'] ?? '0',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  post['liked'] == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 18,
                                  color: post['liked'] == true
                                      ? Colors.red
                                      : Colors.black54,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${post['likes'] ?? 0}',
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<ProfileLogic>();
    super.dispose();
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;
  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }
}
