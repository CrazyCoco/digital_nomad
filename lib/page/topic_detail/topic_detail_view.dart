import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'topic_detail_logic.dart';

class TopicDetailPage extends StatefulWidget {
  const TopicDetailPage({super.key});
  @override
  State<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  final TopicDetailLogic logic = Get.put(TopicDetailLogic());

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
            icon: const Icon(Icons.arrow_back, size: 24),
            onPressed: logic.onBack,
          ),
          title: Text(
            logic.topicTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<TopicDetailLogic>(
          builder: (l) {
            if (l.posts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.explore_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No posts for this topic yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Topic stats
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${l.postsCount}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Posts',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      Column(
                        children: [
                          Text(
                            '${l.participantsCount}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Participants',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Posts list
                ...l.posts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final post = entry.value;
                  return _buildPostCard(post, index);
                }).toList(),
              ],
            );
          },
        ),
      ),
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
                    radius: 20,
                    backgroundColor: const Color(0xFFBBDEFB),
                    backgroundImage: post['avatar'] != null && post['avatar'].isNotEmpty
                        ? AssetImage(post['avatar'])
                        : null,
                    child: (post['avatar'] == null || post['avatar'].isEmpty)
                        ? const Icon(Icons.person, size: 24, color: Color(0xFF2196F3))
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      post['time'],
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post['content'],
              style: const TextStyle(fontSize: 14, height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (post['image'] != null && post['image'].isNotEmpty)
              const SizedBox(height: 12),
            if (post['image'] != null && post['image'].isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  post['image'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                GetBuilder<TopicDetailLogic>(
                  builder: (l) {
                    return GestureDetector(
                      onTap: () => logic.onLike(index),
                      child: Row(
                        children: [
                          Icon(
                            post['liked'] ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: post['liked'] ? Colors.red : Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${post['likes']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: post['liked'] ? Colors.red : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.comment_outlined, size: 20, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      '${post['comments']}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
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
    Get.delete<TopicDetailLogic>();
    super.dispose();
  }
}
