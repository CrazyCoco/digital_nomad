import '../model/user.dart';
import '../model/post.dart';
import '../model/comment.dart';
import '../model/conversation.dart';
import '../model/chat_room.dart';
import '../model/chat_message.dart';
import 'realm_service.dart';

class DataInitializer {
  static final RealmService _realmService = RealmService();

  /// 初始化种子数据
  static void initializeSeedData() {
    print('Initializing seed data...');
    
    // 检查是否已有用户数据
    final existingUsers = _realmService.getAllUsers();
    final hasUsers = existingUsers.isNotEmpty;
    
    // 检查是否已有房间数据
    final existingRooms = _realmService.getAllChatRooms();
    final hasRooms = existingRooms.isNotEmpty;
    
    if (hasUsers && hasRooms) {
      print('All seed data already exists, skipping initialization');
      return;
    }

    // 如果没有任何用户数据，创建所有种子数据
    if (!hasUsers) {
      print('Creating users, posts, comments, and conversations...');
      final users = _createSeedUsers();
      final posts = _createSeedPosts();
      final comments = _createSeedComments();
      final conversations = _createSeedConversations();

      _realmService.insertSeedData(users, posts, comments);
      
      // Insert conversations separately
      for (final conversation in conversations) {
        _realmService.upsertConversation(conversation);
      }
      
      print('Users: ${users.length}');
      print('Posts: ${posts.length}');
      print('Comments: ${comments.length}');
      print('Conversations: ${conversations.length}');
    }
    
    // 如果没有房间数据，创建房间和种子消息
    if (!hasRooms) {
      print('Creating chat rooms...');
      final chatRooms = _createSeedChatRooms();
      
      // Insert chat rooms separately
      for (final room in chatRooms) {
        _realmService.upsertChatRoom(room);
      }
      
      // Create seed messages for each room
      print('Creating seed chat messages...');
      final seedMessages = _createSeedRoomMessages();
      for (final message in seedMessages) {
        _realmService.sendMessage(message);
      }
      
      print('Chat Rooms: ${chatRooms.length}');
      print('Seed Messages: ${seedMessages.length}');
    }
    
    print('Seed data initialized successfully');
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
        'Alice Johnson',
        userAvatar: 'images/head_1.jpg',
        description: '#CoworkingSpace Amazing colab space with fast wifi and great community #RemoteWork',
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
        'Michael Chen',
        userAvatar: 'images/head_2.jpg',
        description: '#CoworkingSpace Perfect spot for remote work with meeting rooms #DigitalNomad',
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
        'Sarah Wilson',
        userAvatar: 'images/head_3.jpg',
        description: '#CoworkingSpace Collaborative workspace with networking events #RemoteWork',
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
        'David Lee',
        userAvatar: 'images/799ddffd8fbda40cd47b3d6887ed2d6c.jpg',
        description: '#NomadLife Morning coffee routine at the beach cafe #TravelTips',
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
        'Emma Davis',
        userAvatar: 'images/bf96945afb419442511807418b87dc16.jpg',
        description: '#NomadLife Perfect workspace with ocean view today #RemoteWork',
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
        'Alice Johnson',
        userAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        description: '#TravelTips Found this amazing hidden gem in Bali #DigitalNomad',
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
        'Michael Chen',
        userAvatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        description: '#NomadLife Working from the mountains - best office ever! #RemoteWork',
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
        'Sarah Wilson',
        userAvatar: 'images/e8b24fae0b4d0815af9ddda8f1476ff8.jpg',
        description: '#DigitalNomad Golden hour coding session by the beach #TravelTips',
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
        'David Lee',
        userAvatar: 'images/f04f96e8b6d909e39f132371413ae7d2.jpg',
        description: '#CoworkingSpace My mobile office setup for today #NomadLife',
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
  
  /// 创建种子会话
  static List<Conversation> _createSeedConversations() {
    final now = DateTime.now();
    return [
      Conversation(
        'private_user_1',
        'user_1',
        'Alice Johnson',
        userAvatar: 'images/head_1.jpg',
        lastMessage: 'Hey! How are you doing?',
        lastMessageTime: now.subtract(const Duration(minutes: 2)),
        unreadCount: 2,
        isOnline: true,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(minutes: 2)),
      ),
      Conversation(
        'private_user_2',
        'user_2',
        'Michael Chen',
        userAvatar: 'images/head_2.jpg',
        lastMessage: 'Let\'s meet up tomorrow!',
        lastMessageTime: now.subtract(const Duration(hours: 1)),
        unreadCount: 0,
        isOnline: false,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(hours: 1)),
      ),
      Conversation(
        'private_user_3',
        'user_3',
        'Sarah Wilson',
        userAvatar: 'images/head_3.jpg',
        lastMessage: 'Thanks for the recommendation',
        lastMessageTime: now.subtract(const Duration(hours: 3)),
        unreadCount: 1,
        isOnline: true,
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(hours: 3)),
      ),
      Conversation(
        'private_user_4',
        'user_4',
        'David Lee',
        userAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        lastMessage: 'See you at the cafe',
        lastMessageTime: now.subtract(const Duration(days: 1)),
        unreadCount: 0,
        isOnline: false,
        createdAt: now.subtract(const Duration(days: 10)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  /// 创建种子聊天室
  static List<ChatRoom> _createSeedChatRooms() {
    final now = DateTime.now();
    return [
      ChatRoom(
        'room_cafe_nomads',
        'Cafe Nomads',
        now,
        now,
        description: 'Connect with fellow nomads at cafes around the world ☕🌍',
        membersCount: 156,
        isHot: true,
        avatar: 'images/head_1.jpg',
      ),
      ChatRoom(
        'room_travel_enthusiasts',
        'Travel Enthusiasts',
        now,
        now,
        description: 'Share travel tips, destinations, and adventures ✈️🗺️',
        membersCount: 243,
        isHot: true,
        avatar: 'images/head_2.jpg',
      ),
      ChatRoom(
        'room_digital_nomads_asia',
        'Digital Nomads Asia',
        now,
        now,
        description: 'Everything about digital nomad life in Asia 🏝️💻',
        membersCount: 189,
        isHot: false,
        avatar: 'images/head_3.jpg',
      ),
      ChatRoom(
        'room_remote_workers',
        'Remote Workers',
        now,
        now,
        description: 'Tips and tricks for productive remote work 🚀💼',
        membersCount: 312,
        isHot: true,
        avatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
      ),
      ChatRoom(
        'room_photography_lovers',
        'Photography Lovers',
        now,
        now,
        description: 'Share your travel photography and get feedback 📸✨',
        membersCount: 98,
        isHot: false,
        avatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
      ),
      ChatRoom(
        'room_tech_talk',
        'Tech Talk',
        now,
        now,
        description: 'Discuss latest tech trends and tools for nomads 💻🔧',
        membersCount: 421,
        isHot: true,
        avatar: 'images/bf96945afb419442511807418b87dc16.jpg',
      ),
      ChatRoom(
        'room_fitness_wellness',
        'Fitness & Wellness',
        now,
        now,
        description: 'Stay fit and healthy while traveling 🏋️‍♀️🧘',
        membersCount: 167,
        isHot: false,
        avatar: 'images/head_1.jpg',
      ),
      ChatRoom(
        'room_foodie_adventures',
        'Foodie Adventures',
        now,
        now,
        description: 'Discover local cuisines and share food experiences 🍜🌮',
        membersCount: 289,
        isHot: true,
        avatar: 'images/head_2.jpg',
      ),
      ChatRoom(
        'room_language_exchange',
        'Language Exchange',
        now,
        now,
        description: 'Practice languages and connect with locals 🗣️🌐',
        membersCount: 134,
        isHot: false,
        avatar: 'images/head_3.jpg',
      ),
      ChatRoom(
        'room_startup_founders',
        'Startup Founders',
        now,
        now,
        description: 'Network with entrepreneurs and share startup stories 🚀💡',
        membersCount: 276,
        isHot: true,
        avatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
      ),
      ChatRoom(
        'room_creative_writers',
        'Creative Writers',
        now,
        now,
        description: 'Share your writing journey and get inspiration ✍️📚',
        membersCount: 112,
        isHot: false,
        avatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
      ),
      ChatRoom(
        'room_crypto_blockchain',
        'Crypto & Blockchain',
        now,
        now,
        description: 'Discuss crypto, DeFi, and blockchain technology ₿⛓️',
        membersCount: 345,
        isHot: true,
        avatar: 'images/bf96945afb419442511807418b87dc16.jpg',
      ),
    ];
  }

  /// 创建房间聊天种子消息
  static List<ChatMessage> _createSeedRoomMessages() {
    final now = DateTime.now();
    final messages = <ChatMessage>[];
    
    // Cafe Nomads 房间消息
    messages.addAll([
      ChatMessage(
        'msg_cafe_1',
        'room_cafe_nomads',
        'user_1',
        'Alice Johnson',
        'Hello, may I invite you to have dinner together?',
        senderAvatar: 'images/head_1.jpg',
        createdAt: now.subtract(const Duration(minutes: 45)),
      ),
      ChatMessage(
        'msg_cafe_2',
        'room_cafe_nomads',
        'user_2',
        'Michael Chen',
        'Sure, I\'d be more than willing to do that.',
        senderAvatar: 'images/head_2.jpg',
        createdAt: now.subtract(const Duration(minutes: 44)),
      ),
      ChatMessage(
        'msg_cafe_3',
        'room_cafe_nomads',
        'user_3',
        'Sarah Wilson',
        'Count me in! I know a great cafe nearby ☕',
        senderAvatar: 'images/head_3.jpg',
        createdAt: now.subtract(const Duration(minutes: 30)),
      ),
      ChatMessage(
        'msg_cafe_4',
        'room_cafe_nomads',
        'user_4',
        'David Lee',
        'I\'ll bring my laptop, we can work and eat! 💻🍕',
        senderAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        createdAt: now.subtract(const Duration(minutes: 15)),
      ),
    ]);
    
    // Travel Enthusiasts 房间消息
    messages.addAll([
      ChatMessage(
        'msg_travel_1',
        'room_travel_enthusiasts',
        'user_3',
        'Sarah Wilson',
        'Just arrived in Thailand! The beaches are amazing 🏖️',
        senderAvatar: 'images/head_3.jpg',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      ChatMessage(
        'msg_travel_2',
        'room_travel_enthusiasts',
        'user_5',
        'Emma Davis',
        'Which island are you at? I\'m planning to visit next week!',
        senderAvatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        createdAt: now.subtract(const Duration(hours: 1, minutes: 45)),
      ),
      ChatMessage(
        'msg_travel_3',
        'room_travel_enthusiasts',
        'user_1',
        'Alice Johnson',
        'Phuket is beautiful this time of year. Highly recommend! ✈️',
        senderAvatar: 'images/head_1.jpg',
        createdAt: now.subtract(const Duration(minutes: 30)),
      ),
    ]);
    
    // Tech Talk 房间消息
    messages.addAll([
      ChatMessage(
        'msg_tech_1',
        'room_tech_talk',
        'user_2',
        'Michael Chen',
        'Has anyone tried the new Flutter 3.16 release? 🚀',
        senderAvatar: 'images/head_2.jpg',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      ChatMessage(
        'msg_tech_2',
        'room_tech_talk',
        'user_4',
        'David Lee',
        'Yes! The performance improvements are incredible. My app loads 40% faster!',
        senderAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        createdAt: now.subtract(const Duration(hours: 2, minutes: 30)),
      ),
      ChatMessage(
        'msg_tech_3',
        'room_tech_talk',
        'user_1',
        'Alice Johnson',
        'I\'m loving the new Material 3 components. Great for modern UI design 🎨',
        senderAvatar: 'images/head_1.jpg',
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      ChatMessage(
        'msg_tech_4',
        'room_tech_talk',
        'user_3',
        'Sarah Wilson',
        'Anyone working with AI/ML integration in mobile apps? Looking for tips!',
        senderAvatar: 'images/head_3.jpg',
        createdAt: now.subtract(const Duration(minutes: 20)),
      ),
    ]);
    
    // Remote Workers 房间消息
    messages.addAll([
      ChatMessage(
        'msg_remote_1',
        'room_remote_workers',
        'user_5',
        'Emma Davis',
        'What\'s your favorite productivity app for remote work?',
        senderAvatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
      ChatMessage(
        'msg_remote_2',
        'room_remote_workers',
        'user_2',
        'Michael Chen',
        'Notion + Slack combo is unbeatable for team collaboration 💪',
        senderAvatar: 'images/head_2.jpg',
        createdAt: now.subtract(const Duration(hours: 3, minutes: 45)),
      ),
      ChatMessage(
        'msg_remote_3',
        'room_remote_workers',
        'user_4',
        'David Lee',
        'I use Todoist for task management. Simple but powerful!',
        senderAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
    ]);
    
    // Foodie Adventures 房间消息
    messages.addAll([
      ChatMessage(
        'msg_food_1',
        'room_foodie_adventures',
        'user_1',
        'Alice Johnson',
        'Just tried the best ramen in Tokyo! 🍜 Must visit Ichiran',
        senderAvatar: 'images/head_1.jpg',
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      ChatMessage(
        'msg_food_2',
        'room_foodie_adventures',
        'user_3',
        'Sarah Wilson',
        'Omg that looks delicious! Adding to my bucket list 😋',
        senderAvatar: 'images/head_3.jpg',
        createdAt: now.subtract(const Duration(hours: 4, minutes: 30)),
      ),
      ChatMessage(
        'msg_food_3',
        'room_foodie_adventures',
        'user_5',
        'Emma Davis',
        'Have you tried the street food in Bangkok? Amazing flavors! 🌶️',
        senderAvatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
    ]);
    
    // Startup Founders 房间消息
    messages.addAll([
      ChatMessage(
        'msg_startup_1',
        'room_startup_founders',
        'user_4',
        'David Lee',
        'Just closed our seed round! \$500K raised 🎉',
        senderAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        createdAt: now.subtract(const Duration(hours: 6)),
      ),
      ChatMessage(
        'msg_startup_2',
        'room_startup_founders',
        'user_2',
        'Michael Chen',
        'Congratulations! What\'s your pitch strategy?',
        senderAvatar: 'images/head_2.jpg',
        createdAt: now.subtract(const Duration(hours: 5, minutes: 30)),
      ),
      ChatMessage(
        'msg_startup_3',
        'room_startup_founders',
        'user_1',
        'Alice Johnson',
        'That\'s awesome! Focus on traction and team. Investors love that 💡',
        senderAvatar: 'images/head_1.jpg',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
    ]);
    
    // Crypto & Blockchain 房间消息
    messages.addAll([
      ChatMessage(
        'msg_crypto_1',
        'room_crypto_blockchain',
        'user_2',
        'Michael Chen',
        'Bitcoin just hit a new all-time high! 📈',
        senderAvatar: 'images/head_2.jpg',
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      ChatMessage(
        'msg_crypto_2',
        'room_crypto_blockchain',
        'user_4',
        'David Lee',
        'Time to HODL! The bull run is just getting started 🚀',
        senderAvatar: 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        createdAt: now.subtract(const Duration(minutes: 45)),
      ),
      ChatMessage(
        'msg_crypto_3',
        'room_crypto_blockchain',
        'user_5',
        'Emma Davis',
        'Anyone looking into DeFi protocols? Yield farming looks promising 🌾',
        senderAvatar: 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        createdAt: now.subtract(const Duration(minutes: 20)),
      ),
    ]);
    
    return messages;
  }
}
