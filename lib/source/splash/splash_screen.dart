import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_chronicle/shared/theme/typography/app_text_type.dart';
import 'package:the_chronicle/shared/theme/typography/app_text_widget.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                        () => AppTextWidget(text: controller.typedText.value, type: AppTextType.headline, color: Colors.white,)

                  ),

                  Obx(
                        () => AnimatedOpacity(
                      opacity: controller.showCursor.value ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        '|',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Obx(
                    () => AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: controller.showTagline.value ? 1 : 0,
                  child: AppTextWidget(text: 'By Keval Patel', type: AppTextType.label, color: Colors.white.withValues(alpha: 0.85),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
