import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../comm/realm_service.dart';

class PostDetailLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  // Post ID for Realm update
  String postId = '';
  // 动态信息
  String userName = 'John Doe';
  String userAvatar = 'images/head_1.jpg';
  String postTime = '2 hours ago';
  String postContent = 'Amazing sunset at the beach! 🌅 #travel #sunset #beach';
  String postImage = 'images/8952cc30813886ec84178206d8877d23.jpg';
  int likes = 256;
  int comments = 48;
  int shares = 12;
  bool isLiked = false;
  
  // 评论数据库 - 不同帖子的差异化评论
  static final Map<String, List<Map<String, dynamic>>> commentsDatabase = {
    'post_1': [
      {
        'user': 'Alice Johnson',
        'avatar': 'images/head_1.jpg',
        'content': 'This looks absolutely stunning! 😍 Where is this place?',
        'time': '1 hour ago',
        'likes': 24,
      },
      {
        'user': 'Michael Chen',
        'avatar': 'images/head_2.jpg',
        'content': 'I was there last month! The wifi is surprisingly good 📶',
        'time': '45 minutes ago',
        'likes': 18,
      },
      {
        'user': 'Sarah Wilson',
        'avatar': 'images/head_3.jpg',
        'content': 'Adding this to my bucket list! ✈️',
        'time': '30 minutes ago',
        'likes': 12,
      },
      {
        'user': 'David Lee',
        'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        'content': 'Perfect spot for a morning coffee session ☕',
        'time': '15 minutes ago',
        'likes': 8,
      },
    ],
    'post_2': [
      {
        'user': 'Emma Davis',
        'avatar': 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        'content': 'Love the minimalist setup! Less is more 🙌',
        'time': '2 hours ago',
        'likes': 32,
      },
      {
        'user': 'Bob Smith',
        'avatar': 'images/799ddffd8fbda40cd47b3d6887ed2d6c.jpg',
        'content': 'What laptop stand are you using? Need recommendations!',
        'time': '1 hour ago',
        'likes': 15,
      },
      {
        'user': 'Carol White',
        'avatar': 'images/bf96945afb419442511807418b87dc16.jpg',
        'content': 'This is goals! 🎯 Working on improving my setup too',
        'time': '40 minutes ago',
        'likes': 21,
      },
    ],
    'post_3': [
      {
        'user': 'Frank Miller',
        'avatar': 'images/e8b24fae0b4d0815af9ddda8f1476ff8.jpg',
        'content': 'Mountain views while coding = productivity boost! 🏔️💻',
        'time': '3 hours ago',
        'likes': 45,
      },
      {
        'user': 'Grace Wilson',
        'avatar': 'images/f04f96e8b6d909e39f132371413ae7d2.jpg',
        'content': 'How\'s the internet connection up there?',
        'time': '2 hours ago',
        'likes': 9,
      },
      {
        'user': 'Henry Moore',
        'avatar': 'images/head_1.jpg',
        'content': 'Nature office > Corporate office any day! 🌲',
        'time': '1 hour ago',
        'likes': 28,
      },
      {
        'user': 'Iris Taylor',
        'avatar': 'images/head_2.jpg',
        'content': 'Inspiring! Makes me want to pack my bags right now 🎒',
        'time': '30 minutes ago',
        'likes': 16,
      },
    ],
    'post_4': [
      {
        'user': 'Jack Anderson',
        'avatar': 'images/head_3.jpg',
        'content': 'Hidden gems like this are why I love being a nomad! 💎',
        'time': '4 hours ago',
        'likes': 38,
      },
      {
        'user': 'Kate Thomas',
        'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        'content': 'The coffee there is amazing too! Try their cold brew ☕❄️',
        'time': '3 hours ago',
        'likes': 22,
      },
      {
        'user': 'Alice Johnson',
        'avatar': 'images/head_1.jpg',
        'content': 'Been following your journey! Keep sharing these spots 📸',
        'time': '2 hours ago',
        'likes': 31,
      },
    ],
    'post_5': [
      {
        'user': 'Michael Chen',
        'avatar': 'images/head_2.jpg',
        'content': 'Golden hour coding hits different! 🌅✨',
        'time': '5 hours ago',
        'likes': 52,
      },
      {
        'user': 'Sarah Wilson',
        'avatar': 'images/head_3.jpg',
        'content': 'This is what dreams are made of! 😍🏖️',
        'time': '4 hours ago',
        'likes': 41,
      },
      {
        'user': 'David Lee',
        'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        'content': 'Work-life balance done right! 👌',
        'time': '3 hours ago',
        'likes': 29,
      },
      {
        'user': 'Emma Davis',
        'avatar': 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        'content': 'Don\'t forget to take breaks and enjoy the view! 🧘‍♀️',
        'time': '2 hours ago',
        'likes': 19,
      },
      {
        'user': 'Frank Miller',
        'avatar': 'images/e8b24fae0b4d0815af9ddda8f1476ff8.jpg',
        'content': 'Screenshot saved for motivation! 💪',
        'time': '1 hour ago',
        'likes': 14,
      },
    ],
    'post_6': [
      {
        'user': 'Grace Wilson',
        'avatar': 'images/f04f96e8b6d909e39f132371413ae7d2.jpg',
        'content': 'Mobile office setup goals! What\'s in your bag? 🎒',
        'time': '6 hours ago',
        'likes': 27,
      },
      {
        'user': 'Henry Moore',
        'avatar': 'images/head_1.jpg',
        'content': 'Tech + Travel = The perfect combination! 🚀✈️',
        'time': '5 hours ago',
        'likes': 33,
      },
      {
        'user': 'Iris Taylor',
        'avatar': 'images/head_2.jpg',
        'content': 'Living the dream! Keep inspiring us 🌟',
        'time': '4 hours ago',
        'likes': 20,
      },
    ],
  };
  
  // 当前帖子的评论列表
  List<Map<String, dynamic>> commentsList = [];
  
  final TextEditingController commentController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      loadPostData(args);
    }
  }
  
  /// 加载帖子数据
  void loadPostData(Map<String, dynamic> postData) {
    postId = postData['id'] ?? '';
    userName = postData['user'] ?? 'Unknown User';
    userAvatar = postData['avatar'] ?? 'images/head_1.jpg';
    postTime = postData['time'] ?? 'Just now';
    postContent = postData['content'] ?? postData['description'] ?? 'No description';
    postImage = postData['image'] ?? postData['images']?.firstOrNull ?? '';
    likes = postData['likes'] ?? 0;
    isLiked = postData['liked'] ?? false;
    comments = postData['comments'] ?? 0;
    shares = postData['shares'] ?? 0;
    
    // 根据帖子ID加载评论（如果没有ID则根据内容生成）
    if (postId.isNotEmpty) {
      _loadCommentsByPostId(postId);
    } else {
      _loadCommentsByContent(postContent);
    }
    
    update();
  }
  
  /// 根据帖子ID加载评论
  void _loadCommentsByPostId(String id) {
    // 使用postId的哈希值来生成伪随机但一致的评论
    final hashCode = id.hashCode.abs();
    final commentIndex = hashCode % commentsDatabase.length;
    final keys = commentsDatabase.keys.toList();
    final selectedKey = keys[commentIndex % keys.length];
    
    commentsList = List<Map<String, dynamic>>.from(
      commentsDatabase[selectedKey]!
    );
    
    // 根据帖子ID稍微调整评论数量
    final adjustment = (hashCode % 3) - 1; // -1, 0, or 1
    if (adjustment > 0 && commentsList.isNotEmpty) {
      // 添加一条额外评论
      commentsList.add({
        'user': 'Alex Johnson',
        'avatar': 'images/head_3.jpg',
        'content': 'Great post! Thanks for sharing 🙏',
        'time': 'Just now',
        'likes': 0,
      });
    } else if (adjustment < 0 && commentsList.length > 2) {
      // 移除最后一条评论
      commentsList.removeLast();
    }
    
    comments = commentsList.length;
  }
  
  /// 根据帖子内容加载评论
  void _loadCommentsByContent(String content) {
    // 使用内容哈希来选择评论模板
    final hashCode = content.hashCode.abs();
    final commentIndex = hashCode % commentsDatabase.length;
    final keys = commentsDatabase.keys.toList();
    final selectedKey = keys[commentIndex % keys.length];
    
    commentsList = List<Map<String, dynamic>>.from(
      commentsDatabase[selectedKey]!
    );
    comments = commentsList.length;
  }
  
  void toggleLike() {
    isLiked = !isLiked;
    if (isLiked) {
      likes++;
    } else {
      likes--;
    }
    
    // Update in Realm if postId exists
    if (postId.isNotEmpty) {
      _realmService.toggleLike(postId);
    }
    
    update();
  }
  
  void addComment() {
    if (commentController.text.trim().isEmpty) {
      return;
    }
    
    commentsList.add({
      'user': 'You',
      'avatar': '',
      'content': commentController.text,
      'time': 'Just now',
      'likes': 0,
    });
    
    comments = commentsList.length;
    commentController.clear();
    update();
  }
  
  void onBack() {
    Get.back();
  }
  
  void onShare() {
    shares++;
    Get.snackbar(
      'Shared!',
      'Post shared successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    update();
  }
  
  void onUserTap() {
    // Navigate to user profile
    Get.back();
    // TODO: NavigationUtil.toUserPage(userName: userName);
  }
  
  void onCommentLike(int commentIndex) {
    if (commentIndex >= 0 && commentIndex < commentsList.length) {
      final comment = commentsList[commentIndex];
      if (comment['liked'] == true) {
        comment['liked'] = false;
        comment['likes'] = (comment['likes'] as int) - 1;
      } else {
        comment['liked'] = true;
        comment['likes'] = (comment['likes'] as int) + 1;
      }
      update();
    }
  }
  
  void onDeleteComment(int commentIndex) {
    if (commentIndex >= 0 && commentIndex < commentsList.length) {
      final comment = commentsList[commentIndex];
      if (comment['user'] == 'You') {
        commentsList.removeAt(commentIndex);
        comments = commentsList.length;
        update();
        Get.snackbar(
          'Deleted',
          'Comment deleted',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }
  
  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
