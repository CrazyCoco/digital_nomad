import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicLogic extends GetxController {
  // 话题列表
  List<Map<String, dynamic>> topics = [
    {
      'title': '#TravelPhotography',
      'description': 'Share your best travel photos',
      'posts': 15234,
      'participants': 8456,
      'color': const Color(0xFFE3F2FD),
    },
    {
      'title': '#DigitalNomad',
      'description': 'Life as a digital nomad',
      'posts': 12890,
      'participants': 6234,
      'color': const Color(0xFFF3E5F5),
    },
    {
      'title': '#RemoteWork',
      'description': 'Tips for remote work',
      'posts': 9876,
      'participants': 5123,
      'color': const Color(0xFFE8F5E9),
    },
    {
      'title': '#CoffeeLovers',
      'description': 'Best coffee spots around the world',
      'posts': 7654,
      'participants': 4321,
      'color': const Color(0xFFFFF3E0),
    },
    {
      'title': '#Adventure',
      'description': 'Adventure seekers unite',
      'posts': 6543,
      'participants': 3456,
      'color': const Color(0xFFFFEBEE),
    },
  ];
  
  void onTopicTap(int index) {
    // TODO: Navigate to topic detail
    print('Navigate to topic: ${topics[index]['title']}');
  }
  
  void onBack() {
    Get.back();
  }
}
