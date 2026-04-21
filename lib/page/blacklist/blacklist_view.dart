import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../model/user.dart';
import '../../routes/app_routes.dart';
import '../../widgets/empty_state_view.dart';

import 'blacklist_logic.dart';

class BlacklistPage extends StatefulWidget {
  const BlacklistPage({super.key});

  @override
  State<BlacklistPage> createState() => _BlacklistPageState();
}

class _BlacklistPageState extends State<BlacklistPage> {
  final BlacklistLogic logic = Get.put(BlacklistLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EEF0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE8EEF0),
          elevation: 0,
          leading: IconButton(
            icon: Image.asset('images/back.png', width: 40, height: 40),
            onPressed: logic.onBack,
          ),
          title: const Text(
            'Blacklist',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<BlacklistLogic>(
          builder: (l) {
            if (l.blacklistUsers.isEmpty) {
              return EmptyStateView(message: 'No blocked users');
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: l.blacklistUsers.length,
              itemBuilder: (context, index) {
                return _buildBlacklistCard(l.blacklistUsers[index], index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlacklistCard(User user, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => NavigationUtil.toUserPage(userName: user.name),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFBBDEFB),
                shape: BoxShape.circle,
                image: user.avatar != null && user.avatar!.isNotEmpty
                    ? DecorationImage(
                        image: AssetImage(user.avatar!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: (user.avatar == null || user.avatar!.isEmpty)
                  ? const Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFF2196F3),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                if (user.bio != null && user.bio!.isNotEmpty)
                  Text(
                    user.bio!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => logic.unblockUser(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red),
              ),
              child: const Text(
                'Unblock',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<BlacklistLogic>();
    super.dispose();
  }
}
