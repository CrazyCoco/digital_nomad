import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailLogic extends GetxController {
  // 动态信息
  String userName = 'John Doe';
  String userAvatar = '';
  String postTime = '2 hours ago';
  String postContent = 'Amazing sunset at the beach! 🌅 #travel #sunset #beach';
  int likes = 256;
  int comments = 48;
  int shares = 12;
  bool isLiked = false;
  
  // 评论列表
  List<Map<String, dynamic>> commentsList = [
    {
      'user': 'Alice Johnson',
      'avatar': '',
      'content': 'Wow, beautiful! 😍',
      'time': '1 hour ago',
      'likes': 12,
    },
    {
      'user': 'Bob Smith',
      'avatar': '',
      'content': 'Where is this?',
      'time': '30 minutes ago',
      'likes': 5,
    },
    {
      'user': 'Carol White',
      'avatar': '',
      'content': 'I want to visit!',
      'time': '15 minutes ago',
      'likes': 8,
    },
  ];
  
  final TextEditingController commentController = TextEditingController();
  
  void toggleLike() {
    isLiked = !isLiked;
    if (isLiked) {
      likes++;
    } else {
      likes--;
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
    
    commentController.clear();
    update();
  }
  
  void onBack() {
    Get.back();
  }
  
  void onShare() {
    // TODO: Share functionality
    print('Share post');
  }
  
  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
