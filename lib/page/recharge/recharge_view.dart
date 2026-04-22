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
            // 余额卡片
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
            
            // 恢复购买按钮
            GetBuilder<RechargeLogic>(
              builder: (l) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: l.restorePurchases,
                    child: const Text(
                      'Restore Purchases',
                      style: TextStyle(color: Color(0xFFFF9800)),
                    ),
                  ),
                ),
              ),
            ),
            
            // 产品列表
            Expanded(
              child: GetBuilder<RechargeLogic>(
                builder: (l) {
                  // 加载中
                  if (l.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  // 内购不可用
                  if (!l.isAvailable) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'In-app purchases are not available',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => Get.back(),
                            child: const Text('Go Back'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // 没有产品
                  if (l.products.isEmpty) {
                    return const Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  
                  // 显示产品列表
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: l.products.length,
                    itemBuilder: (context, index) {
                      final product = l.products[index];
                      final coins = l.productCoinsMap[product.id] ?? 0;
                      final isPopular = coins == 500; // 500金币为热门
                      
                      return GestureDetector(
                        onTap: () => l.recharge(index),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isPopular ? const Color(0xFFFF9800) : Colors.transparent,
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
                                      Text(
                                        '$coins Coins',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product.price, // 从 App Store 获取的价格
                                        style: const TextStyle(fontSize: 16, color: Color(0xFFFF9800)),
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black54),
                                ],
                              ),
                              if (isPopular)
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
                      );
                    },
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
