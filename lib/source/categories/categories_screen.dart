import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_chronicle/core/route_manager/route_constants.dart';
import 'package:the_chronicle/shared/theme/app_colors.dart';
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
              type: AppTextType.headline,
            ),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              controller: controller.tabController,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelColor: AppColors.textRed,
              indicatorColor: AppColors.textRed,
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
              padding: const EdgeInsets.all(8),
              itemCount: controller.articles.length +
                  (controller.hasMore ? 1 : 0),
              separatorBuilder: (_, __) =>
              const SizedBox(height: 5),
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
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.secondary),
                    borderRadius: BorderRadiusGeometry.circular(16)
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      controller.selectedIndex.value = index;
                      Get.toNamed(RouteConstants.detailsScreenFromCategory);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: article.title ?? '',
                            type: AppTextType.title,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                          AppTextWidget(
                            text: article.description ?? '',
                            maxLines: 2,
                            color:
                            Theme.of(context).disabledColor,
                          ),
                        ],
                      ),
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
