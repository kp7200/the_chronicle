import 'package:get/get.dart';
import 'package:the_chronicle/source/interest_selection/controllers/interest_selection_controller.dart';
import '../../source/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<InterestSelectionController>(() => InterestSelectionController());
  }
}
