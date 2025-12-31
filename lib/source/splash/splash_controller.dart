import 'dart:async';
import 'package:get/get.dart';
import 'package:the_chronicle/core/route_manager/route_constants.dart';

class SplashController extends GetxController {
  final String appName = 'The Chronicle';

  final typedText = ''.obs;
  final showCursor = true.obs;
  final showTagline = false.obs;

  static const int typingSpeedMs = 120;
  static const Duration totalSplashDuration = Duration(seconds: 3);

  Timer? _typingTimer;
  Timer? _cursorTimer;

  @override
  void onInit() {
    super.onInit();
    _startTypingEffect();
    _startCursorBlink();
    _navigateToHome();
  }

  void _startTypingEffect() {
    int index = 0;

    _typingTimer = Timer.periodic(
      const Duration(milliseconds: typingSpeedMs),
          (timer) {
        if (index < appName.length) {
          typedText.value += appName[index];
          index++;
        } else {
          timer.cancel();
          showTagline.value = true;
        }
      },
    );
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(
      const Duration(milliseconds: 500),
          (_) => showCursor.toggle(),
    );
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(totalSplashDuration);
    Get.offAllNamed(RouteConstants.interestSelectionScreen);
  }

  @override
  void onClose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.onClose();
  }
}
