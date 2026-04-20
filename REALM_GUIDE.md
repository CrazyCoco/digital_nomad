# Realm 数据库使用指南

## 概述

本项目使用 Realm 作为本地数据库,所有应用数据都存储在本地。

## 架构

```
lib/
├── comm/
│   ├── realm_service.dart      # Realm数据库服务层(单例)
│   └── data_initializer.dart   # 种子数据初始化
├── model/                       # Realm数据模型
│   ├── user.dart               # 用户模型
│   ├── post.dart               # 帖子模型
│   ├── comment.dart            # 评论模型
│   ├── chat_message.dart       # 聊天消息模型
│   ├── conversation.dart       # 会话模型
│   └── settings.dart           # 设置模型
```

## 数据模型

### User (用户)
- id: String (主键)
- name: String
- avatar: String?
- bio: String?
- following: int
- followers: int
- friends: int
- postsCount: int
- isOnline: bool
- createdAt: DateTime
- updatedAt: DateTime

### Post (帖子)
- id: String (主键)
- userId: String
- userName: String
- userAvatar: String?
- description: String?
- image: String?
- videoPath: String?
- isVideo: bool
- likes: int
- comments: int
- shares: int
- isLiked: bool
- category: String? (Colab/Cafe/Outdoor)
- weather: String?
- createdAt: DateTime
- updatedAt: DateTime

### Comment (评论)
- id: String (主键)
- postId: String
- userId: String
- userName: String
- userAvatar: String?
- content: String
- likes: int
- isLiked: bool
- createdAt: DateTime

### ChatMessage (聊天消息)
- id: String (主键)
- conversationId: String
- senderId: String
- senderName: String
- senderAvatar: String?
- content: String
- imageUrl: String?
- videoUrl: String?
- messageType: int (0:text, 1:image, 2:video)
- isRead: bool
- createdAt: DateTime

### Conversation (会话)
- id: String (主键)
- userId: String
- userName: String
- userAvatar: String?
- lastMessage: String?
- lastMessageTime: DateTime?
- unreadCount: int
- isOnline: bool
- createdAt: DateTime
- updatedAt: DateTime

### Settings (设置)
- id: String (主键,固定为'app_settings')
- notifications: bool
- darkMode: bool
- language: String
- updatedAt: DateTime?

## 使用方法

### 1. 获取RealmService实例

```dart
import 'package:digital_nomad/comm/realm_service.dart';

final realmService = RealmService();
```

### 2. 用户操作

```dart
// 创建或更新用户
final user = User('user_1', name: 'John Doe', avatar: 'images/head_1.jpg');
realmService.upsertUser(user);

// 根据ID获取用户
final user = realmService.getUserById('user_1');

// 根据名称获取用户
final user = realmService.getUserByName('John Doe');

// 获取所有用户
final users = realmService.getAllUsers();

// 删除用户
realmService.deleteUser('user_1');
```

### 3. 帖子操作

```dart
// 创建帖子
final post = Post(
  'post_1',
  userId: 'user_1',
  userName: 'John Doe',
  description: 'My first post',
  image: 'images/post.jpg',
  category: 'Cafe',
  createdAt: DateTime.now(),
);
realmService.createPost(post);

// 获取所有帖子
final posts = realmService.getAllPosts();

// 根据分类获取帖子
final cafePosts = realmService.getPostsByCategory('Cafe');

// 切换点赞
realmService.toggleLike('post_1');

// 删除帖子
realmService.deletePost('post_1');
```

### 4. 评论操作

```dart
// 添加评论
final comment = Comment(
  'comment_1',
  postId: 'post_1',
  userId: 'user_2',
  userName: 'Jane Doe',
  content: 'Great post!',
  createdAt: DateTime.now(),
);
realmService.addComment(comment);

// 获取帖子的评论
final comments = realmService.getCommentsByPostId('post_1');

// 删除评论
realmService.deleteComment('comment_1');
```

### 5. 聊天操作

```dart
// 发送消息
final message = ChatMessage(
  'msg_1',
  conversationId: 'conv_1',
  senderId: 'user_1',
  senderName: 'John',
  content: 'Hello!',
  messageType: 0,
  createdAt: DateTime.now(),
);
realmService.sendMessage(message);

// 获取会话消息
final messages = realmService.getMessagesByConversation('conv_1');

// 标记为已读
realmService.markMessagesAsRead('conv_1');
```

### 6. 会话操作

```dart
// 创建或更新会话
final conversation = Conversation(
  'conv_1',
  userId: 'user_2',
  userName: 'Jane',
  createdAt: DateTime.now(),
);
realmService.upsertConversation(conversation);

// 获取所有会话
final conversations = realmService.getAllConversations();

// 更新未读数
realmService.updateUnreadCount('conv_1', 5);
```

### 7. 设置操作

```dart
// 获取设置
final settings = realmService.getSettings();

// 更新通知设置
realmService.updateNotifications(true);

// 更新暗黑模式
realmService.updateDarkMode(false);

// 更新语言
realmService.updateLanguage('Chinese');
```

## 数据初始化

应用启动时会自动初始化种子数据:

```dart
// lib/main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  // 初始化Realm
  final realmService = RealmService();
  await realmService.init();
  
  // 初始化种子数据(如果不存在)
  DataInitializer.initializeSeedData();
  
  runApp(MyApp());
}
```

种子数据包括:
- 5个示例用户
- 9个示例帖子(3个Colab, 3个Cafe, 3个Outdoor)
- 5个示例评论

## 注意事项

1. **主键唯一性**: 每个模型都有String类型的主键id,必须保证唯一
2. **必填字段**: 标记为`late`的字段是必填的,可选字段使用`?`
3. **DateTime**: Realm支持DateTime类型,会自动序列化
4. **关系**: 当前版本不使用Realm的关系功能,通过ID关联
5. **事务**: 所有写操作都在事务中进行,确保数据一致性
6. **线程安全**: RealmService是单例,可以在任何线程使用

## 迁移现有代码

要将现有的内存数据迁移到Realm:

1. 在Logic类中注入RealmService
2. 将List<Map>改为从Realm查询
3. 将数据修改改为调用RealmService的方法
4. 移除硬编码的mock数据

示例:

```dart
// Before
class HomeLogic extends GetxController {
  final List<Map<String, dynamic>> posts = [...];
}

// After
class HomeLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  List<Post> get posts => _realmService.getPostsByCategory(currentCategory);
  
  void toggleLike(int index) {
    final post = posts[index];
    _realmService.toggleLike(post.id);
    update();
  }
}
```

## 调试

查看Realm数据库文件位置:

```dart
import 'package:realm/realm.dart';

print(Realm.configuration.path);
```

可以使用 [Realm Studio](https://www.mongodb.com/products/tools/realm-studio) 查看和编辑数据库。

## 性能优化

1. **批量操作**: 使用`insertSeedData`批量插入数据
2. **索引**: 频繁查询的字段可以添加索引
3. **懒加载**: 只在需要时查询数据
4. **缓存**: 对于不常变化的数据可以缓存结果

## 备份和恢复

```dart
// 备份数据库
import 'dart:io';

final dbPath = Realm.configuration.path;
final backupPath = '/path/to/backup.realm';
await File(dbPath).copy(backupPath);

// 恢复数据库
await File(backupPath).copy(dbPath);
```
