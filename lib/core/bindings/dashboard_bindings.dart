import 'package:get/get.dart';
import 'package:the_chronicle/source/categories/categories_controller.dart';
import '../../source/dashboard/controllers/dashboard_controller.dart';
import '../../source/main_navigation/main_navigation_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    Get.lazyPut<CategoriesController>(() => CategoriesController());
  }
}