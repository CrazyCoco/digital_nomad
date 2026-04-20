import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'report_logic.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportLogic logic = Get.put(ReportLogic());

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
            'Report',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Why are you reporting this?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildReasonList(),
                      const SizedBox(height: 20),
                      _buildDescriptionField(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GetBuilder<ReportLogic>(
                builder: (l) {
                  return GestureDetector(
                    onTap: l.isSubmitting ? null : logic.submitReport,
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: l.isSubmitting ? Colors.grey : Colors.black,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Center(
                        child: l.isSubmitting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Submit Report',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
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

  Widget _buildReasonList() {
    return GetBuilder<ReportLogic>(
      builder: (l) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: l.reportReasons.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => l.selectReason(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: l.selectedReason == index
                      ? const Color(0xFFE3F2FD)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: l.selectedReason == index
                        ? const Color(0xFF2196F3)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      l.selectedReason == index
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: l.selectedReason == index
                          ? const Color(0xFF2196F3)
                          : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l.reportReasons[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: l.selectedReason == index
                              ? const Color(0xFF2196F3)
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional details (optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: logic.descriptionController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Provide more information about the issue...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<ReportLogic>();
    super.dispose();
  }
}
