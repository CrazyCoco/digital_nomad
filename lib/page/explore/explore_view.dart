import 'package:digital_nomad/page/post/post_view.dart';
import 'package:digital_nomad/page/explore/explore_logic.dart';
import 'package:digital_nomad/widgets/empty_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
          Image.asset("images/icon_103.png", width: 109),
          GestureDetector(
            onTap: () => Get.to(() => const PostPage()),
            child: Image.asset("images/icon_105.png", width: 88),
          ),
        ],
      ),
    );
  }

  Widget _buildHotTopics() {
    return GetBuilder<ExploreLogic>(
      builder: (l) {
        return GestureDetector(
          onTap: logic.onTopicTap,
          child: SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: l.hotTopics.length,
              itemBuilder: (context, index) {
                final topic = l.hotTopics[index];
                return GestureDetector(
                  onTap: () => l.onTopicItemTap(index),
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: topic['image'] != null
                                ? Image.asset(topic['image'], fit: BoxFit.cover)
                                : Container(color: topic['color']),
                          ),
                        ),
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
                  ),
                );
              },
            ),
          ),
        );
      },
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
        if (l.displayPosts.isEmpty) {
          return EmptyStateView(
            message: l.contentTab == 1
                ? 'No posts from followed users yet'
                : 'No posts available',
          );
        }
        
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: l.displayPosts.length,
          itemBuilder: (context, index) {
            return _buildPostCard(l.displayPosts[index], index);
          },
        );
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, int index) {
    return GestureDetector(
      onTap: () => logic.onPostTap(index),
      child: Container(
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
                  onTap: () => logic.onUserTap(post['user']),
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
            GestureDetector(
              onTap: () => logic.onPostTap(index),
              child: Text(
                post['content'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            if (post['images'] != null && post['images'].length > 0)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 120,
                      margin: post['images'].length > 1
                          ? const EdgeInsets.only(right: 8)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(post['images'][0], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  if (post['images'].length > 1)
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
                    GestureDetector(
                      onTap: () => logic.onReportPost(index),
                      child: const Icon(
                        Icons.error_outline,
                        size: 24,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ExploreLogic>();
    super.dispose();
  }
}
