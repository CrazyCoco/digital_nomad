import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'recharge_logic.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({super.key});
  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  final RechargeLogic logic = Get.put(RechargeLogic());

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
          title: const Text('Recharge'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            GetBuilder<RechargeLogic>(
              builder: (l) => Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF9800), Color(0xFFFFB74D)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text('Current Balance', style: TextStyle(fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text('${l.currentBalance} Coins', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: logic.packages.length,
                itemBuilder: (context, index) {
                  final pkg = logic.packages[index];
                  return GetBuilder<RechargeLogic>(
                    builder: (l) => GestureDetector(
                      onTap: () => l.recharge(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: pkg['popular'] ? const Color(0xFFFF9800) : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${pkg['coins']} Coins', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(pkg['price'], style: const TextStyle(fontSize: 16, color: Color(0xFFFF9800))),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black54),
                              ],
                            ),
                            if (pkg['popular'])
                              Positioned(
                                top: -10,
                                right: -10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF9800),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(14)),
                                  ),
                                  child: const Text('Popular', style: TextStyle(fontSize: 12, color: Colors.white)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<RechargeLogic>();
    super.dispose();
  }
}
