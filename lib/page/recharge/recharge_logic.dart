import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class RechargeLogic extends GetxController {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  
  int currentBalance = 1000;
  bool isAvailable = false;
  bool isLoading = false;
  List<ProductDetails> products = [];
  
  // iOS 内购产品 ID（需要在 App Store Connect 中配置）
  static const List<String> _productIds = [
    'com.digitalnomad.coins.100',
    'com.digitalnomad.coins.500',
    'com.digitalnomad.coins.1000',
    'com.digitalnomad.coins.5000',
  ];
  
  // 产品与金币的映射
  Map<String, int> get productCoinsMap => {
    'com.digitalnomad.coins.100': 100,
    'com.digitalnomad.coins.500': 500,
    'com.digitalnomad.coins.1000': 1000,
    'com.digitalnomad.coins.5000': 5000,
  };
  
  @override
  void onInit() {
    super.onInit();
    _initializeInAppPurchase();
  }
  
  /// 初始化内购
  Future<void> _initializeInAppPurchase() async {
    // 检查内购是否可用
    final available = await _inAppPurchase.isAvailable();
    isAvailable = available;
    update();
    
    if (!available) {
      print('In-app purchases are not available');
      return;
    }
    
    // 监听购买更新
    _listenToPurchaseUpdates();
    
    // 加载产品信息
    await loadProducts();
  }
  
  /// 监听购买状态更新
  void _listenToPurchaseUpdates() {
    _subscription = _inAppPurchase.purchaseStream.listen(
      (purchaseDetailsList) {
        _handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        print('Error in purchase stream: $error');
        _showErrorDialog('Purchase Error', error.toString());
      },
    );
  }
  
  /// 处理购买更新
  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          print('Purchase pending...');
          break;
          
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _verifyAndDeliverProduct(purchaseDetails);
          break;
          
        case PurchaseStatus.error:
          print('Purchase error: ${purchaseDetails.error}');
          _showErrorDialog(
            'Purchase Failed',
            purchaseDetails.error?.message ?? 'Unknown error',
          );
          break;
          
        case PurchaseStatus.canceled:
          print('Purchase canceled');
          break;
      }
      
      // 如果不是待处理状态，完成购买
      if (purchaseDetails.status != PurchaseStatus.pending) {
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }
  
  /// 验证并发放商品
  void _verifyAndDeliverProduct(PurchaseDetails purchaseDetails) {
    final productId = purchaseDetails.productID;
    final coins = productCoinsMap[productId];
    
    if (coins != null) {
      // 增加余额
      currentBalance += coins;
      update();
      
      // 显示成功提示
      Get.snackbar(
        'Success',
        'Recharged $coins coins!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      print('Purchase verified: $productId - $coins coins added');
    } else {
      print('Unknown product: $productId');
    }
  }
  
  /// 加载产品信息
  Future<void> loadProducts() async {
    if (!isAvailable) return;
    
    isLoading = true;
    update();
    
    try {
      final response = await _inAppPurchase.queryProductDetails(_productIds.toSet());
      
      if (response.notFoundIDs.isNotEmpty) {
        print('Products not found: ${response.notFoundIDs}');
      }
      
      if (response.error != null) {
        print('Error loading products: ${response.error}');
        _showErrorDialog('Load Error', response.error!.message);
        return;
      }
      
      products = response.productDetails;
      isLoading = false;
      update();
      
      print('Loaded ${products.length} products');
    } catch (e) {
      print('Exception loading products: $e');
      isLoading = false;
      update();
    }
  }
  
  /// 购买指定产品
  void recharge(int index) {
    if (!isAvailable) {
      _showErrorDialog('Not Available', 'In-app purchases are not available');
      return;
    }
    
    if (index >= products.length) {
      _showErrorDialog('Error', 'Invalid product');
      return;
    }
    
    final product = products[index];
    
    // 创建购买参数
    final purchaseParam = PurchaseParam(productDetails: product);
    
    // 发起购买
    _inAppPurchase.buyConsumable(
      purchaseParam: purchaseParam,
      autoConsume: true, // iOS 不需要，但 Android 需要
    );
    
    print('Initiating purchase for: ${product.id}');
  }
  
  /// 恢复购买
  Future<void> restorePurchases() async {
    if (!isAvailable) {
      _showErrorDialog('Not Available', 'In-app purchases are not available');
      return;
    }
    
    try {
      await _inAppPurchase.restorePurchases();
      Get.snackbar(
        'Restoring',
        'Restoring previous purchases...',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Restore error: $e');
      _showErrorDialog('Restore Failed', e.toString());
    }
  }
  
  /// 显示错误对话框
  void _showErrorDialog(String title, String message) {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  void onBack() => Get.back();
  
  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
