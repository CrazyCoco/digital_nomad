import 'package:digital_nomad/page/post/post_view.dart';
import 'package:digital_nomad/page/explore/explore_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ExploreLogic logic = Get.put(ExploreLogic());

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
                      _buildHotTopics(),
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
            'Explore',
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
          GestureDetector(
            onTap: () => Get.to(() => const PostPage()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Text(
                    '+Post',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text('😊', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotTopics() {
    return GestureDetector(
      onTap: logic.onTopicTap,
      child: SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: logic.hotTopics.length,
          itemBuilder: (context, index) {
            final topic = logic.hotTopics[index];
            return Container(
              width: 200,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: topic['image'] != null
                          ? Image.asset(topic['image'], fit: BoxFit.cover)
                          : Container(color: topic['color']),
                    ),
                  ),
                  // Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Hot',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          topic['title'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.remove_red_eye,
                              size: 14,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              topic['views'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildContentTabs() {
    return GetBuilder<ExploreLogic>(
      builder: (l) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => l.selectContentTab(0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: l.contentTab == 0
                            ? const Color(0xFF42A5F5)
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    'Popular',
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: l.contentTab == 1
                            ? const Color(0xFF42A5F5)
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    'Following',
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
    return GetBuilder<ExploreLogic>(
      builder: (l) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: l.posts.length,
          itemBuilder: (context, index) {
            return _buildPostCard(l.posts[index], index);
          },
        );
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, int index) {
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
          Row(
            children: [
              GestureDetector(
                onTap: () => NavigationUtil.toUserPage(userName: post['user']),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: post['avatar'] != null
                      ? AssetImage(post['avatar'])
                      : null,
                  backgroundColor: const Color(0xFFBBDEFB),
                  child: post['avatar'] == null
                      ? const Icon(
                          Icons.person,
                          size: 30,
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
                    post['user'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    post['time'],
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
              const Spacer(),
              GetBuilder<ExploreLogic>(
                builder: (l) {
                  return GestureDetector(
                    onTap: () => l.toggleFollow(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: post['following']
                              ? Colors.black26
                              : const Color(0xFF42A5F5),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        post['following'] ? 'Following' : 'Follow',
                        style: TextStyle(
                          fontSize: 14,
                          color: post['following']
                              ? Colors.black54
                              : const Color(0xFF42A5F5),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post['content'],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: post['images'] != null && post['images'].length > 0
                        ? Image.asset(post['images'][0], fit: BoxFit.cover)
                        : Container(
                            color: const Color(0xFFE1F5FE),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 40,
                                color: Color(0xFF90CAF9),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              if (post['images'] != null && post['images'].length > 1)
                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(post['images'][1], fit: BoxFit.cover),
                    ),
                  ),
                )
              else
                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1F5FE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 40,
                        color: Color(0xFF90CAF9),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.remove_red_eye,
                    size: 16,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    post['views'],
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  GetBuilder<ExploreLogic>(
                    builder: (l) {
                      return GestureDetector(
                        onTap: () => l.toggleLike(index),
                        child: Icon(
                          post['liked']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 24,
                          color: post['liked'] ? Colors.red : Colors.black54,
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          post['liked'] ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: post['liked'] ? Colors.red : Colors.black54,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${post['likes']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: post['liked'] ? Colors.red : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.error_outline,
                    size: 24,
                    color: Colors.black54,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ExploreLogic>();
    super.dispose();
  }
}
