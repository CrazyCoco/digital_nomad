import 'package:digital_nomad/page/onboarding/onboarding_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final OnboardingLogic logic = Get.put(OnboardingLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EEF0),
        body: Stack(
          children: [
            // Page view with fullscreen images
            PageView.builder(
              controller: logic.pageController,
              onPageChanged: logic.updatePage,
              itemCount: logic.pages.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  'images/icon_${index + 1}.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
            // Back button
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 15,
              child: IconButton(
                icon: Image.asset('images/back.png', width: 40, height: 40),
                onPressed: logic.onSkip,
              ),
            ),
            // Page indicators
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: GetBuilder<OnboardingLogic>(
                builder: (logic) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      logic.pages.length,
                      (index) => Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == logic.currentPage
                              ? const Color(0xFF42A5F5)
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Next button (only on last page)
            Positioned(
              bottom: 80,
              left: 24,
              right: 24,
              child: GetBuilder<OnboardingLogic>(
                builder: (logic) {
                  if (logic.currentPage != logic.pages.length - 1) {
                    return const SizedBox.shrink();
                  }
                  return GestureDetector(
                    onTap: logic.onSkip,
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
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

  @override
  void dispose() {
    Get.delete<OnboardingLogic>();
    super.dispose();
  }
}
