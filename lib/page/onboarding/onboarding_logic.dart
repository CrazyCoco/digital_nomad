import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_routes.dart';

class OnboardingLogic extends GetxController {
  // Page controller for onboarding
  final PageController pageController = PageController();

  // Current page index
  int currentPage = 0;

  // Onboarding data
  final List<OnboardingData> pages = [
    OnboardingData(
      title: 'Find Your Perfect Workspace',
      description:
          'Discover hidden cafes, cozy colabs, and stunning outdoor spots shared by nomads around the world. Where will you work today?',
      color: const Color(0xFF7BC67E),
    ),
    OnboardingData(
      title: 'Share Your Journey',
      description:
          'Post videos of your favorite workspaces, inspire others with your setup, and show the world where you\'re creating from.',
      color: const Color(0xFFFFC107),
    ),
    OnboardingData(
      title: 'Connect with Like-Minded Nomads',
      description:
          'Join topic-based chat rooms, ask questions, share tips, and build real connections with fellow location-independent professionals.',
      color: const Color(0xFF42A5F5),
    ),
  ];

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// Update current page
  void updatePage(int index) {
    currentPage = index;
    update();
  }

  /// Skip onboarding
  void onSkip() {
    // Mark onboarding as completed
    GetStorage().write('onboarding_completed', true);
    NavigationUtil.toMainTab();
  }

  /// Go to next page or complete
  void onNext() {
    if (currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      onSkip();
    }
  }
}

class OnboardingData {
  final String title;
  final String description;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.color,
  });
}
