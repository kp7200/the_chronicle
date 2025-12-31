import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              /// 📰 App name typing animation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                        () => Text(
                      controller.typedText.value,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.6,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  /// ✨ Blinking cursor
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

              /// 🧠 Tagline fade-in
              Obx(
                    () => AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: controller.showTagline.value ? 1 : 0,
                  child: Text(
                    'Truth, one headline at a time.',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.2,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
