import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'like_ranking_logic.dart';

class LikeRankingPage extends StatefulWidget {
  const LikeRankingPage({super.key});
  @override
  State<LikeRankingPage> createState() => _LikeRankingPageState();
}

class _LikeRankingPageState extends State<LikeRankingPage> {
  final LikeRankingLogic logic = Get.put(LikeRankingLogic());

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
          title: const Text('Like Ranking'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: logic.rankings.length,
          itemBuilder: (context, index) {
            final user = logic.rankings[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(
                    '#${user['rank']}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: index == 0 ? Colors.amber : (index == 1 ? Colors.grey : Colors.brown),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFBBDEFB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 30, color: Color(0xFF2196F3)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${user['likes']} likes', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<LikeRankingLogic>();
    super.dispose();
  }
}
