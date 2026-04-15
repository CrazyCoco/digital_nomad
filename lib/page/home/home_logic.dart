import 'package:get/get.dart';

class HomeLogic extends GetxController {
  // Tab controller
  int selectedTab = 0;
  
  // Category tabs
  final List<String> categories = ['Colab', 'Cafe', 'Outdoor'];
  int selectedCategory = 0;
  
  // Mock data for "You might like"
  final List<Map<String, dynamic>> suggestedUsers = [
    {'name': 'User 1', 'online': true},
    {'name': 'User 2', 'online': false},
    {'name': 'User 3', 'online': true},
    {'name': 'User 4', 'online': false},
    {'name': 'User 5', 'online': false},
  ];
  
  // Mock data for posts
  final List<Map<String, dynamic>> posts = [
    {
      'user': 'Cali Vibes',
      'time': '11:00AM',
      'description': 'DescriptionDescriptionDescriptionDescriptionD',
      'likes': 38,
      'liked': true,
      'weather': 'sunny',
    },
    {
      'user': 'Cali Vibes',
      'time': '11:00AM',
      'description': 'DescriptionDescriptionDescriptionDescriptionD',
      'likes': 25,
      'liked': false,
      'weather': 'sunny',
    },
  ];
  
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
  
  /// Select bottom tab
  void selectTab(int index) {
    selectedTab = index;
    update();
  }
  
  /// Toggle like
  void toggleLike(int postIndex) {
    posts[postIndex]['liked'] = !posts[postIndex]['liked'];
    if (posts[postIndex]['liked']) {
      posts[postIndex]['likes']++;
    } else {
      posts[postIndex]['likes']--;
    }
    update();
  }
}
