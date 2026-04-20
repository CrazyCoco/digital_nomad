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
          actions: [
            GetBuilder<TopicDetailLogic>(
              builder: (l) {
                return TextButton(
                  onPressed: l.onJoinTopic,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: l.isJoined ? Colors.grey[300] : const Color(0xFF42A5F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      l.isJoined ? 'Joined' : 'Join',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: l.isJoined ? Colors.black54 : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
                    const SizedBox(height: 8),
                    Text(
                      'Be the first to share!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Topic header card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.topicDescription,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
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
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey[300],
                          ),
                          Column(
                            children: [
                              Text(
                                l.topicViews,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Views',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Top contributors
                if (l.topContributors.isNotEmpty) ...[
                  Text(
                    'Top Contributors',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: l.topContributors.length,
                      itemBuilder: (context, index) {
                        final contributor = l.topContributors[index];
                        return GestureDetector(
                          onTap: () => l.onContributorTap(
                            contributor['userId'],
                            contributor['userName'],
                          ),
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: const Color(0xFFBBDEFB),
                                  backgroundImage: contributor['avatar'] != null && 
                                      contributor['avatar'].isNotEmpty
                                      ? AssetImage(contributor['avatar'])
                                      : null,
                                  child: (contributor['avatar'] == null || 
                                      contributor['avatar'].isEmpty)
                                      ? const Icon(Icons.person, size: 28, 
                                          color: Color(0xFF2196F3))
                                      : null,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  contributor['userName'].split(' ').first,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${contributor['postCount']} posts',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
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
                Expanded(
                  child: Column(
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
            if (post['image'] != null && post['image'].isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  post['image'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
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
                const SizedBox(width: 16),
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
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => logic.onShare(index),
                  child: Row(
                    children: const [
                      Icon(Icons.share_outlined, size: 20, color: Colors.black54),
                      SizedBox(width: 4),
                      Text(
                        'Share',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${post['views']} views',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
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
