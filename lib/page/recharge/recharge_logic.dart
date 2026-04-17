import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargeLogic extends GetxController {
  int currentBalance = 1000;
  
  List<Map<String, dynamic>> packages = [
    {'coins': 100, 'price': '\$0.99', 'popular': false},
    {'coins': 500, 'price': '\$4.99', 'popular': true},
    {'coins': 1000, 'price': '\$9.99', 'popular': false},
    {'coins': 5000, 'price': '\$39.99', 'popular': false},
  ];
  
  void onBack() => Get.back();
  
  void recharge(int index) {
    final package = packages[index];
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirm Purchase'),
        content: Text('Buy ${package['coins']} coins for ${package['price']}?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
              currentBalance += package['coins'] as int;
              update();
              Get.snackbar('Success', 'Recharged ${package['coins']} coins', snackPosition: SnackPosition.BOTTOM);
            },
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }
}
