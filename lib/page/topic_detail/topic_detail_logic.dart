import 'package:get/get.dart';

class TopicDetailLogic extends GetxController {
  String topicTitle = '#TravelPhotography';
  String topicDescription = 'Share your best travel photos';
  int postsCount = 15234;
  int participantsCount = 8456;
  
  List<Map<String, dynamic>> posts = [
    {'user': 'Alice', 'content': 'Beautiful sunset!', 'likes': 128, 'time': '2h ago'},
    {'user': 'Bob', 'content': 'Mountain view', 'likes': 256, 'time': '5h ago'},
    {'user': 'Carol', 'content': 'Beach vibes', 'likes': 64, 'time': '1d ago'},
  ];
  
  void onBack() => Get.back();
}
