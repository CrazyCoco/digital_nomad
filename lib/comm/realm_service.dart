import 'package:realm/realm.dart';
import '../model/user.dart';
import '../model/post.dart';
import '../model/comment.dart';
import '../model/chat_message.dart';
import '../model/conversation.dart';
import '../model/settings.dart';

class RealmService {
  static final RealmService _instance = RealmService._internal();
  factory RealmService() => _instance;
  RealmService._internal();

  late Realm _realm;
  bool _isInitialized = false;

  /// 初始化Realm数据库
  Future<void> init() async {
    if (_isInitialized) return;

    final config = Configuration.local([
      User.schema,
      Post.schema,
      Comment.schema,
      ChatMessage.schema,
      Conversation.schema,
      Settings.schema,
    ]);

    _realm = Realm(config);
    _isInitialized = true;
    
    // 初始化默认设置
    _initDefaultSettings();
    
    print('Realm database initialized successfully');
  }

  /// 初始化默认设置
  void _initDefaultSettings() {
    final existingSettings = getSettings();
    if (existingSettings == null) {
      final settings = Settings('app_settings');
      _realm.write(() {
        _realm.add(settings);
      });
    }
  }

  /// 获取Realm实例
  Realm get realm => _realm;

  /// 检查是否已初始化
  bool get isInitialized => _isInitialized;

  /// 关闭数据库
  void close() {
    if (_isInitialized) {
      _realm.close();
      _isInitialized = false;
    }
  }

  // ==================== User Operations ====================

  /// 创建或更新用户
  User upsertUser(User user) {
    return _realm.write(() {
      return _realm.add(user, update: true);
    });
  }

  /// 根据ID获取用户
  User? getUserById(String id) {
    return _realm.find<User>(id);
  }

  /// 根据名称获取用户
  User? getUserByName(String name) {
    final users = _realm.all<User>().where((u) => u.name == name);
    return users.isNotEmpty ? users.first : null;
  }

  /// 获取所有用户
  List<User> getAllUsers() {
    return _realm.all<User>().toList();
  }

  /// 删除用户
  void deleteUser(String id) {
    final user = _realm.find<User>(id);
    if (user != null) {
      _realm.write(() {
        _realm.delete(user);
      });
    }
  }

  // ==================== Post Operations ====================

  /// 创建帖子
  Post createPost(Post post) {
    return _realm.write(() {
      return _realm.add(post);
    });
  }

  /// 更新帖子
  Post updatePost(Post post) {
    return _realm.write(() {
      return _realm.add(post, update: true);
    });
  }

  /// 获取所有帖子
  List<Post> getAllPosts() {
    return _realm.all<Post>().toList();
  }

  /// 根据分类获取帖子
  List<Post> getPostsByCategory(String category) {
    return _realm.all<Post>()
        .where((p) => p.category == category)
        .toList();
  }

  /// 根据ID获取帖子
  Post? getPostById(String id) {
    return _realm.find<Post>(id);
  }

  /// 删除帖子
  void deletePost(String id) {
    final post = _realm.find<Post>(id);
    if (post != null) {
      _realm.write(() {
        _realm.delete(post);
      });
    }
  }

  /// 切换点赞状态
  void toggleLike(String postId) {
    final post = _realm.find<Post>(postId);
    if (post != null) {
      _realm.write(() {
        post.isLiked = !post.isLiked;
        post.likes = post.isLiked ? post.likes + 1 : post.likes - 1;
      });
    }
  }

  // ==================== Comment Operations ====================

  /// 添加评论
  Comment addComment(Comment comment) {
    return _realm.write(() {
      return _realm.add(comment);
    });
  }

  /// 获取帖子的评论
  List<Comment> getCommentsByPostId(String postId) {
    return _realm.all<Comment>()
        .where((c) => c.postId == postId)
        .toList();
  }

  /// 删除评论
  void deleteComment(String id) {
    final comment = _realm.find<Comment>(id);
    if (comment != null) {
      _realm.write(() {
        _realm.delete(comment);
      });
    }
  }

  // ==================== Chat Operations ====================

  /// 发送消息
  ChatMessage sendMessage(ChatMessage message) {
    return _realm.write(() {
      return _realm.add(message);
    });
  }

  /// 获取会话消息
  List<ChatMessage> getMessagesByConversation(String conversationId) {
    return _realm.all<ChatMessage>()
        .where((m) => m.conversationId == conversationId)
        .toList()
      ..sort((a, b) {
        final aTime = a.createdAt;
        final bTime = b.createdAt;
        if (aTime == null || bTime == null) return 0;
        return bTime.compareTo(aTime);
      });
  }

  /// 标记消息为已读
  void markMessagesAsRead(String conversationId) {
    final messages = _realm.all<ChatMessage>()
        .where((m) => m.conversationId == conversationId && !m.isRead);
    
    _realm.write(() {
      for (final message in messages) {
        message.isRead = true;
      }
    });
  }

  // ==================== Conversation Operations ====================

  /// 创建或更新会话
  Conversation upsertConversation(Conversation conversation) {
    return _realm.write(() {
      return _realm.add(conversation, update: true);
    });
  }

  /// 获取所有会话
  List<Conversation> getAllConversations() {
    return _realm.all<Conversation>().toList();
  }

  /// 获取单个会话
  Conversation? getConversationById(String id) {
    return _realm.find<Conversation>(id);
  }

  /// 更新未读数
  void updateUnreadCount(String conversationId, int count) {
    final conversation = _realm.find<Conversation>(conversationId);
    if (conversation != null) {
      _realm.write(() {
        conversation.unreadCount = count;
      });
    }
  }

  // ==================== Settings Operations ====================

  /// 获取设置
  Settings? getSettings() {
    return _realm.find<Settings>('app_settings');
  }

  /// 更新设置
  void updateSettings(Settings settings) {
    _realm.write(() {
      _realm.add(settings, update: true);
    });
  }

  /// 更新通知设置
  void updateNotifications(bool enabled) {
    final settings = getSettings();
    if (settings != null) {
      _realm.write(() {
        settings.notifications = enabled;
      });
    }
  }

  /// 更新暗黑模式
  void updateDarkMode(bool enabled) {
    final settings = getSettings();
    if (settings != null) {
      _realm.write(() {
        settings.darkMode = enabled;
      });
    }
  }

  /// 更新语言
  void updateLanguage(String language) {
    final settings = getSettings();
    if (settings != null) {
      _realm.write(() {
        settings.language = language;
      });
    }
  }

  // ==================== Batch Operations ====================

  /// 批量插入种子数据
  void insertSeedData(List<User> users, List<Post> posts, List<Comment> comments) {
    _realm.write(() {
      for (final user in users) {
        _realm.add(user, update: true);
      }
      for (final post in posts) {
        _realm.add(post, update: true);
      }
      for (final comment in comments) {
        _realm.add(comment, update: true);
      }
    });
  }

  /// 清空所有数据
  void clearAllData() {
    _realm.write(() {
      _realm.deleteAll<User>();
      _realm.deleteAll<Post>();
      _realm.deleteAll<Comment>();
      _realm.deleteAll<ChatMessage>();
      _realm.deleteAll<Conversation>();
      // 保留设置
    });
  }
}
