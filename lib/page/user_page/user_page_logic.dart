import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class UserPageLogic extends GetxController {
  // 用户信息
  String userName = 'John Doe';
  String userAvatar = 'images/head_1.jpg';
  String userBio = 'Digital nomad | Travel enthusiast | Coffee lover';
  int followingCount = 256;
  int followersCount = 1024;
  int friendsCount = 128;
  int postsCount = 45;
  
  // Tab 选择
  int selectedTab = 0;
  final List<String> tabs = ['Posts', 'Likes'];
  
  // 关注状态
  bool isFollowing = false;
  
  // 用户数据库 - 不同用户的差异化数据
  static final Map<String, Map<String, dynamic>> userData = {
    'Alice Johnson': {
      'avatar': 'images/head_1.jpg',
      'bio': 'Travel blogger & photographer 📸 | Exploring the world one cafe at a time ☕',
      'following': 342,
      'followers': 2048,
      'friends': 156,
      'posts': 67,
      'posts_data': [
        {
          'image': 'images/8952cc30813886ec84178206d8877d23.jpg',
          'likes': 234,
          'comments': 45,
          'time': '1 hour ago',
          'liked': false,
        },
        {
          'image': 'images/948f9b32fa7f2957bc82ec3100b057aa.jpg',
          'likes': 567,
          'comments': 89,
          'time': '3 hours ago',
          'liked': true,
        },
        {
          'image': 'images/afc548276bf301d627730fb09e06be7f.jpg',
          'likes': 123,
          'comments': 23,
          'time': '6 hours ago',
          'liked': false,
        },
        {
          'image': 'images/c7f144445b754ddd4f6745199bff2c7e.jpg',
          'likes': 890,
          'comments': 134,
          'time': '1 day ago',
          'liked': false,
        },
      ],
    },
    'Michael Chen': {
      'avatar': 'images/head_2.jpg',
      'bio': 'Software Engineer 💻 | Digital Nomad 🌍 | Coffee Addict ☕',
      'following': 189,
      'followers': 1523,
      'friends': 98,
      'posts': 52,
      'posts_data': [
        {
          'image': 'images/cc6d2957689aa46c4a647284da1a9fa8.jpg',
          'likes': 345,
          'comments': 56,
          'time': '2 hours ago',
          'liked': false,
        },
        {
          'image': 'images/e9e17b651b4ea0d747218bb73cf4e8a8.jpg',
          'likes': 678,
          'comments': 92,
          'time': '5 hours ago',
          'liked': true,
        },
        {
          'image': 'images/f015fcc3321bfeaeab116c3b5f93c438.jpg',
          'likes': 234,
          'comments': 34,
          'time': '8 hours ago',
          'liked': false,
        },
        {
          'image': 'images/f3a487b2839073b7b2bf23f4981df1d4.jpg',
          'likes': 456,
          'comments': 67,
          'time': '1 day ago',
          'liked': false,
        },
      ],
    },
    'Sarah Wilson': {
      'avatar': 'images/head_3.jpg',
      'bio': 'Content Creator ✨ | Lifestyle & Travel | Living my best life 🌟',
      'following': 567,
      'followers': 3456,
      'friends': 234,
      'posts': 89,
      'posts_data': [
        {
          'image': 'images/094de2a3d0f251804bbdf971c36c97ad.jpg',
          'likes': 789,
          'comments': 123,
          'time': '30 minutes ago',
          'liked': true,
        },
        {
          'image': 'images/16dcb0bf7d0f122690c0b0e1916494d4.jpg',
          'likes': 456,
          'comments': 78,
          'time': '2 hours ago',
          'liked': false,
        },
        {
          'image': 'images/175948fe83a531afbaf9a1bada957c27.jpg',
          'likes': 1234,
          'comments': 189,
          'time': '4 hours ago',
          'liked': true,
        },
        {
          'image': 'images/17faa625fce16f5d297a2e29dd15f716.jpg',
          'likes': 567,
          'comments': 90,
          'time': '12 hours ago',
          'liked': false,
        },
      ],
    },
    'David Lee': {
      'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
      'bio': 'Entrepreneur 🚀 | Building startups from anywhere | Mentor & Advisor',
      'following': 423,
      'followers': 5678,
      'friends': 312,
      'posts': 134,
      'posts_data': [
        {
          'image': 'images/34a543da13c67f1fb1d6df299533f332.jpg',
          'likes': 1567,
          'comments': 234,
          'time': '1 hour ago',
          'liked': false,
        },
        {
          'image': 'images/3d9b5922a426a5f4afa12fb082489111.jpg',
          'likes': 890,
          'comments': 145,
          'time': '3 hours ago',
          'liked': true,
        },
        {
          'image': 'images/40a805d3d08ff56df9c03c35d55e5191.jpg',
          'likes': 2345,
          'comments': 345,
          'time': '7 hours ago',
          'liked': false,
        },
        {
          'image': 'images/6a92315ff42af7de93e441d5dc581ea5.jpg',
          'likes': 678,
          'comments': 98,
          'time': '1 day ago',
          'liked': false,
        },
      ],
    },
    'Emma Davis': {
      'avatar': 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
      'bio': 'Yoga Instructor 🧘‍♀️ | Wellness Coach | Mindful Traveler 🕉️',
      'following': 234,
      'followers': 4567,
      'friends': 189,
      'posts': 156,
      'posts_data': [
        {
          'image': 'images/799ddffd8fbda40cd47b3d6887ed2d6c.jpg',
          'likes': 2345,
          'comments': 456,
          'time': '45 minutes ago',
          'liked': true,
        },
        {
          'image': 'images/bf96945afb419442511807418b87dc16.jpg',
          'likes': 1234,
          'comments': 234,
          'time': '2 hours ago',
          'liked': false,
        },
        {
          'image': 'images/e8b24fae0b4d0815af9ddda8f1476ff8.jpg',
          'likes': 3456,
          'comments': 567,
          'time': '5 hours ago',
          'liked': true,
        },
        {
          'image': 'images/f04f96e8b6d909e39f132371413ae7d2.jpg',
          'likes': 890,
          'comments': 123,
          'time': '10 hours ago',
          'liked': false,
        },
      ],
    },
  };
  
  // 动态列表
  List<Map<String, dynamic>> posts = [];
  
  @override
  void onInit() {
    super.onInit();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['userName'] != null) {
      loadUserData(args['userName']);
    }
  }
  
  /// 加载用户数据
  void loadUserData(String name) {
    userName = name;
    
    // 查找用户数据，如果不存在则使用默认数据
    final data = userData[name];
    if (data != null) {
      userAvatar = data['avatar'];
      userBio = data['bio'];
      followingCount = data['following'];
      followersCount = data['followers'];
      friendsCount = data['friends'];
      postsCount = data['posts'];
      posts = List<Map<String, dynamic>>.from(data['posts_data']);
    } else {
      // 默认数据
      userAvatar = 'images/head_1.jpg';
      userBio = 'Digital nomad | Travel enthusiast | Coffee lover';
      followingCount = 256;
      followersCount = 1024;
      friendsCount = 128;
      postsCount = 45;
      posts = [
        {
          'image': 'images/8952cc30813886ec84178206d8877d23.jpg',
          'likes': 128,
          'comments': 24,
          'time': '2 hours ago',
          'liked': false,
        },
        {
          'image': 'images/948f9b32fa7f2957bc82ec3100b057aa.jpg',
          'likes': 256,
          'comments': 48,
          'time': '5 hours ago',
          'liked': true,
        },
        {
          'image': 'images/afc548276bf301d627730fb09e06be7f.jpg',
          'likes': 64,
          'comments': 12,
          'time': '1 day ago',
          'liked': false,
        },
      ];
    }
    update();
  }
  
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  void toggleFollow() {
    isFollowing = !isFollowing;
    if (isFollowing) {
      followersCount++;
    } else {
      followersCount--;
    }
    update();
  }
  
  void toggleLike(int index) {
    posts[index]['liked'] = !posts[index]['liked'];
    if (posts[index]['liked']) {
      posts[index]['likes']++;
    } else {
      posts[index]['likes']--;
    }
    update();
  }
  
  void onBack() {
    Get.back();
  }
  
  void onEditProfile() {
    // TODO: Navigate to edit profile
    print('Edit profile');
  }
  
  void onMessage() {
    NavigationUtil.toPrivateChat(
      userName: userName,
      userAvatar: userAvatar,
    );
  }
  
  void onMoreOptions() {
    // TODO: Show more options menu
    print('More options');
  }
}
