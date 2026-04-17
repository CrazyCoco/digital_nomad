import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportLogic extends GetxController {
  // 举报原因选项
  List<String> reportReasons = [
    'Spam or misleading',
    'Harassment or bullying',
    'Inappropriate content',
    'Hate speech',
    'Violence or dangerous organizations',
    'Intellectual property violation',
    'Fake account',
    'Other',
  ];
  
  int? selectedReason;
  final TextEditingController descriptionController = TextEditingController();
  
  void selectReason(int index) {
    selectedReason = index;
    update();
  }
  
  void submitReport() {
    if (selectedReason == null) {
      Get.snackbar(
        'Error',
        'Please select a reason',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    
    // TODO: Submit report to backend
    print('Report submitted');
    print('Reason: ${reportReasons[selectedReason!]}');
    print('Description: ${descriptionController.text}');
    
    Get.back();
    Get.snackbar(
      'Success',
      'Report submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void onBack() {
    Get.back();
  }
  
  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
