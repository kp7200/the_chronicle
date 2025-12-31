import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/typography/app_text_widget.dart';
import '../../../shared/theme/typography/app_text_type.dart';
import 'categories_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      init: CategoriesController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const AppTextWidget(
              text: 'Categories',
              type: AppTextType.display,
            ),
            bottom: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              tabs: controller.categories
                  .map((c) => Tab(text: c.capitalizeFirst))
                  .toList(),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value &&
                controller.articles.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              controller: controller.scrollController, // 🔥 key part
              padding: const EdgeInsets.all(16),
              itemCount: controller.articles.length +
                  (controller.hasMore ? 1 : 0),
              separatorBuilder: (_, __) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == controller.articles.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final article = controller.articles[index];

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: article.title ?? '',
                          type: AppTextType.title,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        AppTextWidget(
                          text: article.description ?? '',
                          maxLines: 3,
                          color:
                          Theme.of(context).disabledColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
}
