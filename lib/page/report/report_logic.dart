import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ReportLogic extends GetxController {
  // 被举报信息
  String reportedType = 'post';
  String reportedUserName = '';
  String reportedContent = '';
  
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
  bool isSubmitting = false;
  
  @override
  void onInit() {
    super.onInit();
    // Get arguments from route
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      reportedType = args['reportedType'] ?? 'post';
      reportedUserName = args['reportedUserName'] ?? '';
      reportedContent = args['reportedContent'] ?? '';
    }
  }
  
  void selectReason(int index) {
    selectedReason = index;
    update();
  }
  
  void submitReport() {
    if (selectedReason == null) {
      showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: const Text('Please select a reason for reporting'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    
    // Show loading
    EasyLoading.show(status: 'Submitting report...');
    isSubmitting = true;
    update();
    
    // TODO: Submit report to backend
    // Example:
    // await ReportService.submitReport(
    //   reason: reportReasons[selectedReason!],
    //   description: descriptionController.text,
    //   reportedUserId: reportedUserId,
    //   reportedPostId: reportedPostId,
    // );
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
      isSubmitting = false;
      update();
      
      // Show success dialog
      showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Thank You'),
          content: const Text(
            'Your report has been submitted. We will review it and take appropriate action.',
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Get.back(); // Close dialog
                Get.back(); // Go back to previous page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      
      print('Report submitted');
      print('Reason: ${reportReasons[selectedReason!]}');
      print('Description: ${descriptionController.text}');
    });
  }
  
  void onBack() {
    if (isSubmitting) {
      showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Wait'),
          content: const Text('Please wait while submitting the report'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    Get.back();
  }
  
  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
