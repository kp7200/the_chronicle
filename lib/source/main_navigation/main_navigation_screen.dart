import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../shared/theme/app_colors.dart';
import '../categories/categories_screen.dart';
import '../dashboard/presentations/dashboard_screen.dart';
import 'main_navigation_controller.dart';

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const DashboardScreen(),
      CategoriesScreen(),
    ];

    return Scaffold(
      extendBody: true,

      body: Obx(
            () => IndexedStack(
          index: controller.currentIndex.value,
          children: screens,
        ),
      ),

      bottomNavigationBar: Obx(
            () => SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor:
                Theme.of(context).colorScheme.surface,
                selectedItemColor: AppColors.textRed,
                unselectedItemColor:
                Theme.of(context).disabledColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded,),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category_rounded),
                    label: 'Categories',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
