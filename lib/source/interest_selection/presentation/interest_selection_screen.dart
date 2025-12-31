import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_chronicle/core/route_manager/route_constants.dart';
import 'package:the_chronicle/shared/theme/app_colors.dart';
import 'package:the_chronicle/shared/theme/typography/app_text_type.dart';
import 'package:the_chronicle/shared/theme/typography/app_text_widget.dart';
import 'package:the_chronicle/source/interest_selection/widgets/app_category_pill.dart';

import '../controllers/interest_selection_controller.dart';

class InterestSelectionScreen extends GetView<InterestSelectionController> {
  const InterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTextWidget(text: "The Chronicle", type: AppTextType.headline,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 64, bottom: 72),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(text: "Select the category,", type: AppTextType.label,),
                Row(
                  children: [
                    AppTextWidget(text: "You", type: AppTextType.display,),
                    AppTextWidget(text: " Love!", type: AppTextType.display, color: AppColors.textRed,),
                  ],
                ),
              ],
            ),
            Obx( ()=>
              Wrap(
                spacing: 8,
                runSpacing: 16,
                children: List.generate(controller.categories.length,
                      (index) => AppCategoryPill(
                        title: controller.categories[index],
                        isSelected: controller.selectedIndex.value == index,
                        // color: ? AppColors.textRed : AppColors.primary,
                        onTap: () {
                          controller.onSelection(index);
                          },
                      ),
                )
              ),
            ),
            Obx( () =>
              Visibility(
                  visible: controller.selectedCategory.isNotEmpty,
                  replacement: SizedBox(height: 48,),
                  child: SizedBox(
                    height: 48,
                    width: Get.width,
                    child: ElevatedButton(
                        onPressed: (){
                          Get.toNamed(RouteConstants.main, arguments: {'category' : controller.selectedCategory.value});
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(AppColors.textRed),
                          elevation: WidgetStatePropertyAll(4)
                        ),
                        child: AppTextWidget(text: "Continue", color: AppColors.textOnPrimary, type: AppTextType.title,)
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
