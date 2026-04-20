import '../model/user.dart';
import '../model/post.dart';
import '../model/comment.dart';
import 'realm_service.dart';

class DataInitializer {
  static final RealmService _realmService = RealmService();

  /// 初始化种子数据
  static void initializeSeedData() {
    print('Initializing seed data...');
    
    // 检查是否已有数据
    final existingUsers = _realmService.getAllUsers();
    if (existingUsers.isNotEmpty) {
      print('Seed data already exists, skipping initialization');
      return;
    }

    final users = _createSeedUsers();
    final posts = _createSeedPosts();
    final comments = _createSeedComments();

    _realmService.insertSeedData(users, posts, comments);
    print('Seed data initialized successfully');
    print('Users: ${users.length}');
    print('Posts: ${posts.length}');
    print('Comments: ${comments.length}');
  }

  /// 创建种子用户
  static List<User> _createSeedUsers() {
    final now = DateTime.now();
    return [
      User(
        'user_1',
        'Alice Johnson',
        avatar: 'images/head_1.jpg',
        bio: 'Travel blogger & photographer 📸 | Exploring the world one cafe at a time ☕',
        following: 342,
        followers: 2048,
        friends: 156,
        postsCount: 67,
        isOnline: true,
        createdAt: now,
        updatedAt: now,
      ),
      User(
        'user_2',
        'Michael Chen',
        avatar: 'images/head_2.jpg',
        bio: 'Software Engineer 💻 | Digital Nomad 🌍 | Coffee Addict ☕',
        following: 189,
        followers: 1523,
        friends: 98,
        postsCount: 52,
        isOnline: false,
        createdAt: now,
        updatedAt: now,
      ),
      User(
        'user_3',
        'Sarah Wilson',
        avatar: 'images/head_3.jpg',
        bio: 'Content Creator ✨ | Lifestyle & Travel | Living my best life 🌟',
        following: 567,
        followers: 3456,
        friends: 234,
        postsCount: 89,
        isOnline: true,
        createdAt: now,
        updatedAt: now,
      ),
      User(
        'user_4',
        'David Lee',
        avatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        bio: 'Entrepreneur 🚀 | Building startups from anywhere | Mentor & Advisor',
        following: 423,
        followers: 5678,
        friends: 312,
        postsCount: 134,
        isOnline: false,
        createdAt: now,
        updatedAt: now,
      ),
      User(
        'user_5',
        'Emma Davis',
        avatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        bio: 'Yoga Instructor 🧘‍♀️ | Wellness Coach | Mindful Traveler 🕉️',
        following: 234,
        followers: 4567,
        friends: 189,
        postsCount: 156,
        isOnline: true,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  /// 创建种子帖子
  static List<Post> _createSeedPosts() {
    final now = DateTime.now();
    return [
      // Colab category
      Post(
        'post_1',
        'user_1',
        'CoWork Space',
        userAvatar: 'images/head_1.jpg',
        description: 'Amazing colab space with fast wifi and great community',
        image: 'images/8952cc30813886ec84178206d8877d23.jpg',
        videoPath: 'images/100cbbc25bf271dc459d54e00fc218e9_720w.mp4',
        isVideo: true,
        likes: 45,
        comments: 12,
        shares: 5,
        isLiked: false,
        category: 'Colab',
        weather: 'sunny',
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now,
      ),
      Post(
        'post_2',
        'user_2',
        'Digital Hub',
        userAvatar: 'images/head_2.jpg',
        description: 'Perfect spot for remote work with meeting rooms',
        image: 'images/948f9b32fa7f2957bc82ec3100b057aa.jpg',
        videoPath: 'images/132d3ac74640afb9545dc9e51ce8e9df.mp4',
        isVideo: true,
        likes: 62,
        comments: 18,
        shares: 8,
        isLiked: true,
        category: 'Colab',
        weather: 'cloudy',
        createdAt: now.subtract(const Duration(hours: 5)),
        updatedAt: now,
      ),
      Post(
        'post_3',
        'user_3',
        'Nomad Base',
        userAvatar: 'images/head_3.jpg',
        description: 'Collaborative workspace with networking events',
        image: 'images/afc548276bf301d627730fb09e06be7f.jpg',
        videoPath: 'images/1a6954309c550d60b48b9bd001b0f370_720w.mp4',
        isVideo: true,
        likes: 38,
        comments: 9,
        shares: 3,
        isLiked: false,
        category: 'Colab',
        weather: 'sunny',
        createdAt: now.subtract(const Duration(hours: 8)),
        updatedAt: now,
      ),
      // Cafe category
      Post(
        'post_4',
        'user_4',
        'Cali Vibes',
        userAvatar: 'images/799ddffd8fbda40cd47b3d6887ed2d6c.jpg',
        description: 'Morning coffee routine at the beach cafe',
        image: 'images/094de2a3d0f251804bbdf971c36c97ad.jpg',
        videoPath: 'images/21c7b75472e945ffb863608cdef26353_t4.mp4',
        isVideo: true,
        likes: 38,
        comments: 15,
        shares: 6,
        isLiked: true,
        category: 'Cafe',
        weather: 'sunny',
        createdAt: now.subtract(const Duration(hours: 3)),
        updatedAt: now,
      ),
      Post(
        'post_5',
        'user_5',
        'Beach Worker',
        userAvatar: 'images/bf96945afb419442511807418b87dc16.jpg',
        description: 'Perfect workspace with ocean view today',
        image: 'images/16dcb0bf7d0f122690c0b0e1916494d4.jpg',
        videoPath: 'images/2fb94a98f92223b765c6adf89a701950.mp4',
        isVideo: true,
        likes: 25,
        comments: 7,
        shares: 2,
        isLiked: false,
        category: 'Cafe',
        weather: 'sunny',
        createdAt: now.subtract(const Duration(hours: 6)),
        updatedAt: now,
      ),
      Post(
        'post_6',
        'user_1',
        'Cafe Hopper',
        userAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        description: 'Found this amazing hidden gem in Bali',
        image: 'images/17faa625fce16f5d297a2e29dd15f716.jpg',
        videoPath: 'images/3e024ae4241ef369444b673969845350_t1.mp4',
        isVideo: true,
        likes: 67,
        comments: 22,
        shares: 11,
        isLiked: true,
        category: 'Cafe',
        weather: 'sunny',
        createdAt: now.subtract(const Duration(hours: 10)),
        updatedAt: now,
      ),
      // Outdoor category
      Post(
        'post_7',
        'user_2',
        'Mountain Nomad',
        userAvatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        description: 'Working from the mountains - best office ever!',
        image: 'images/175948fe83a531afbaf9a1bada957c27.jpg',
        videoPath: 'images/65dbfdc6ee1b1a98375af7136ee1f389_540w.mp4',
        isVideo: true,
        likes: 52,
        comments: 14,
        shares: 7,
        isLiked: false,
        category: 'Outdoor',
        weather: 'cloudy',
        createdAt: now.subtract(const Duration(hours: 4)),
        updatedAt: now,
      ),
      Post(
        'post_8',
        'user_3',
        'Sunset Coder',
        userAvatar: 'images/e8b24fae0b4d0815af9ddda8f1476ff8.jpg',
        description: 'Golden hour coding session by the beach',
        image: 'images/34a543da13c67f1fb1d6df299533f332.jpg',
        videoPath: 'images/70895d0ffb161f2436a84572c944ea08.mp4',
        isVideo: true,
        likes: 89,
        comments: 28,
        shares: 15,
        isLiked: false,
        category: 'Outdoor',
        weather: 'sunny',
        createdAt: now.subtract(const Duration(hours: 7)),
        updatedAt: now,
      ),
      Post(
        'post_9',
        'user_4',
        'Travel Dev',
        userAvatar: 'images/f04f96e8b6d909e39f132371413ae7d2.jpg',
        description: 'My mobile office setup for today',
        image: 'images/3d9b5922a426a5f4afa12fb082489111.jpg',
        videoPath: 'images/9649291a6f97744972f96b52aa154b66_720w.mp4',
        isVideo: true,
        likes: 43,
        comments: 11,
        shares: 4,
        isLiked: false,
        category: 'Outdoor',
        weather: 'partly_cloudy',
        createdAt: now.subtract(const Duration(hours: 12)),
        updatedAt: now,
      ),
    ];
  }

  /// 创建种子评论
  static List<Comment> _createSeedComments() {
    final now = DateTime.now();
    return [
      Comment(
        'comment_1',
        'post_1',
        'user_2',
        'Michael Chen',
        'This looks absolutely stunning! 😍 Where is this place?',
        userAvatar: 'images/head_2.jpg',
        likes: 24,
        isLiked: false,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      Comment(
        'comment_2',
        'post_1',
        'user_3',
        'Sarah Wilson',
        'I was there last month! The wifi is surprisingly good 📶',
        userAvatar: 'images/head_3.jpg',
        likes: 18,
        isLiked: true,
        createdAt: now.subtract(const Duration(minutes: 45)),
      ),
      Comment(
        'comment_3',
        'post_2',
        'user_1',
        'Alice Johnson',
        'Love the minimalist setup! Less is more 🙌',
        userAvatar: 'images/head_1.jpg',
        likes: 32,
        isLiked: false,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      Comment(
        'comment_4',
        'post_4',
        'user_5',
        'Emma Davis',
        'The coffee there is amazing too! Try their cold brew ☕❄️',
        userAvatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        likes: 22,
        isLiked: true,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      Comment(
        'comment_5',
        'post_7',
        'user_4',
        'David Lee',
        'Mountain views while coding = productivity boost! 🏔️💻',
        userAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        likes: 45,
        isLiked: false,
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
    ];
  }
}
