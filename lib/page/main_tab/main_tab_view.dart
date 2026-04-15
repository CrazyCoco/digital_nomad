import 'package:digital_nomad/page/chat/chat_view.dart';
import 'package:digital_nomad/page/explore/explore_view.dart';
import 'package:digital_nomad/page/home/home_view.dart';
import 'package:digital_nomad/page/main_tab/main_tab_logic.dart';
import 'package:digital_nomad/page/profile/profile_view.dart';
import 'package:digital_nomad/page/store/store_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  final MainTabLogic logic = Get.put(MainTabLogic());

  final List<Widget> pages = [
    const HomePage(),
    const ExplorePage(),
    const ChatPage(),
    const StorePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EEF0),
        body: GetBuilder<MainTabLogic>(
          builder: (l) => IndexedStack(index: l.selectedIndex, children: pages),
        ),
        bottomNavigationBar: GetBuilder<MainTabLogic>(
          builder: (l) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home, 'Home'),
                _buildNavItem(1, Icons.explore, 'Explore'),
                _buildNavItem(2, Icons.chat_bubble_outline, 'Chat'),
                _buildNavItem(3, Icons.store, 'Store'),
                _buildNavItem(4, Icons.person_outline, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () => logic.selectTab(index),
      child: GetBuilder<MainTabLogic>(
        builder: (l) {
          final isSelected = l.selectedIndex == index;
          return Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFBBDEFB)
                  : Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: isSelected ? Colors.black : Colors.white,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MainTabLogic>();
    super.dispose();
  }
}
