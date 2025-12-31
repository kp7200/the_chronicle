import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:the_chronicle/core/bindings/dashboard_bindings.dart';
import 'package:the_chronicle/core/bindings/splash_binding.dart';
import 'package:the_chronicle/source/interest_selection/presentation/interest_selection_screen.dart';
import 'package:the_chronicle/source/main_navigation/main_navigation_screen.dart';
import 'package:the_chronicle/source/splash/splash_screen.dart';
import '../../source/dashboard/presentations/dashboard_screen.dart';

class RouteConstants {
  static const String initial = '/';
  static const String dashboardScreen = '/dashboard';
  static const String interestSelectionScreen = '/interestSelectionScreen';
  static const String main = '/main';
}

List<GetPage<dynamic>>? appRoutes() {
  final appRoutes = [
    GetPage(name: RouteConstants.initial, page: () => SplashScreen(), binding: SplashBinding()),
    GetPage(name: RouteConstants.interestSelectionScreen, page: () => InterestSelectionScreen(),),
    GetPage(name: RouteConstants.dashboardScreen, page: () => DashboardScreen(), binding: DashboardBindings()),
    GetPage(name: RouteConstants.main, page: () => MainNavigationScreen(), binding: DashboardBindings()),
    // GetPage(name: RouteConstants.dashboardScreen, page: () => DashboardScreen(), binding: DashboardBindings()),
  ];

  return appRoutes;
}
