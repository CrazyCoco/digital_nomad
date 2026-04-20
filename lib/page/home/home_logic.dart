import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class HomeLogic extends GetxController {
  // Tab controller
  int selectedTab = 0;
  
  // Category tabs
  final List<String> categories = ['Colab', 'Cafe', 'Outdoor'];
  int selectedCategory = 0;
  
  // Mock data for "You might like"
  final List<Map<String, dynamic>> suggestedUsers = [
    {'name': 'User 1', 'online': true, 'avatar': 'images/head_1.jpg'},
    {'name': 'User 2', 'online': false, 'avatar': 'images/head_2.jpg'},
    {'name': 'User 3', 'online': true, 'avatar': 'images/head_3.jpg'},
    {'name': 'User 4', 'online': false, 'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg'},
    {'name': 'User 5', 'online': false, 'avatar': 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg'},
  ];
  
  // Mock data for posts by category
  final Map<String, List<Map<String, dynamic>>> postsByCategory = {
    'Colab': [
      {
        'user': 'CoWork Space',
        'time': '10:30AM',
        'description': 'Amazing colab space with fast wifi and great community',
        'likes': 45,
        'liked': false,
        'weather': 'sunny',
        'image': 'images/8952cc30813886ec84178206d8877d23.jpg',
        'avatar': 'images/head_1.jpg',
        'isVideo': true,
        'videoPath': 'images/100cbbc25bf271dc459d54e00fc218e9_720w.mp4',
      },
      {
        'user': 'Digital Hub',
        'time': '2:15PM',
        'description': 'Perfect spot for remote work with meeting rooms',
        'likes': 62,
        'liked': true,
        'weather': 'cloudy',
        'image': 'images/948f9b32fa7f2957bc82ec3100b057aa.jpg',
        'avatar': 'images/head_2.jpg',
        'isVideo': true,
        'videoPath': 'images/132d3ac74640afb9545dc9e51ce8e9df.mp4',
      },
      {
        'user': 'Nomad Base',
        'time': '4:00PM',
        'description': 'Collaborative workspace with networking events',
        'likes': 38,
        'liked': false,
        'weather': 'sunny',
        'image': 'images/afc548276bf301d627730fb09e06be7f.jpg',
        'avatar': 'images/head_3.jpg',
        'isVideo': true,
        'videoPath': 'images/1a6954309c550d60b48b9bd001b0f370_720w.mp4',
      },
    ],
    'Cafe': [
      {
        'user': 'Cali Vibes',
        'time': '11:00AM',
        'description': 'Morning coffee routine at the beach cafe',
        'likes': 38,
        'liked': true,
        'weather': 'sunny',
        'image': 'images/094de2a3d0f251804bbdf971c36c97ad.jpg',
        'avatar': 'images/799ddffd8fbda40cd47b3d6887ed2d6c.jpg',
        'isVideo': true,
        'videoPath': 'images/21c7b75472e945ffb863608cdef26353_t4.mp4',
      },
      {
        'user': 'Beach Worker',
        'time': '2:30PM',
        'description': 'Perfect workspace with ocean view today',
        'likes': 25,
        'liked': false,
        'weather': 'sunny',
        'image': 'images/16dcb0bf7d0f122690c0b0e1916494d4.jpg',
        'avatar': 'images/bf96945afb419442511807418b87dc16.jpg',
        'isVideo': true,
        'videoPath': 'images/2fb94a98f92223b765c6adf89a701950.mp4',
      },
      {
        'user': 'Cafe Hopper',
        'time': '4:45PM',
        'description': 'Found this amazing hidden gem in Bali',
        'likes': 67,
        'liked': true,
        'weather': 'sunny',
        'image': 'images/17faa625fce16f5d297a2e29dd15f716.jpg',
        'avatar': 'images/11ab81bc0daf3ec42e19a7adfa33bb57.jpg',
        'isVideo': true,
        'videoPath': 'images/3e024ae4241ef369444b673969845350_t1.mp4',
      },
    ],
    'Outdoor': [
      {
        'user': 'Mountain Nomad',
        'time': '9:15AM',
        'description': 'Working from the mountains - best office ever!',
        'likes': 52,
        'liked': false,
        'weather': 'cloudy',
        'image': 'images/175948fe83a531afbaf9a1bada957c27.jpg',
        'avatar': 'images/47bc300ec1f66b7e5ca75c05b341621e.jpg',
        'isVideo': true,
        'videoPath': 'images/65dbfdc6ee1b1a98375af7136ee1f389_540w.mp4',
      },
      {
        'user': 'Sunset Coder',
        'time': '6:30PM',
        'description': 'Golden hour coding session by the beach',
        'likes': 89,
        'liked': false,
        'weather': 'sunny',
        'image': 'images/34a543da13c67f1fb1d6df299533f332.jpg',
        'avatar': 'images/e8b24fae0b4d0815af9ddda8f1476ff8.jpg',
        'isVideo': true,
        'videoPath': 'images/70895d0ffb161f2436a84572c944ea08.mp4',
      },
      {
        'user': 'Travel Dev',
        'time': '10:00AM',
        'description': 'My mobile office setup for today',
        'likes': 43,
        'liked': false,
        'weather': 'partly_cloudy',
        'image': 'images/3d9b5922a426a5f4afa12fb082489111.jpg',
        'avatar': 'images/f04f96e8b6d909e39f132371413ae7d2.jpg',
        'isVideo': true,
        'videoPath': 'images/9649291a6f97744972f96b52aa154b66_720w.mp4',
      },
    ],
  };
  
  // Current posts based on selected category
  List<Map<String, dynamic>> get posts => postsByCategory[categories[selectedCategory]] ?? [];
  
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  
  /// Select category
  void selectCategory(int index) {
    selectedCategory = index;
    update();
  }
  
  /// Get current category name
  String get currentCategory => categories[selectedCategory];
  
  /// Select bottom tab
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  /// Toggle like
  void toggleLike(int postIndex) {
    final currentPosts = posts;
    if (postIndex >= 0 && postIndex < currentPosts.length) {
      currentPosts[postIndex]['liked'] = !currentPosts[postIndex]['liked'];
      if (currentPosts[postIndex]['liked']) {
        currentPosts[postIndex]['likes']++;
      } else {
        currentPosts[postIndex]['likes']--;
      }
      update();
    }
  }
  
  /// Navigate to post detail
  void onPostTap(int index) {
    final currentPosts = posts;
    if (index >= 0 && index < currentPosts.length) {
      NavigationUtil.toPostDetail(postData: currentPosts[index]);
    }
  }
  
  /// Play video
  void onPlayVideo(int index) {
    final currentPosts = posts;
    if (index >= 0 && index < currentPosts.length) {
      final post = currentPosts[index];
      if (post['isVideo'] == true && post['videoPath'] != null) {
        NavigationUtil.toVideoPlayer(videoPath: post['videoPath']);
      }
    }
  }
  
  /// Report post
  void onReportPost(int index) {
    final currentPosts = posts;
    if (index >= 0 && index < currentPosts.length) {
      final post = currentPosts[index];
      NavigationUtil.toReport(
        reportedType: 'post',
        reportedUserName: post['user'] ?? 'Unknown',
        reportedContent: post['description'] ?? '',
      );
    }
  }
}
