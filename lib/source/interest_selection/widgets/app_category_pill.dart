import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_chronicle/shared/theme/app_colors.dart';
import '../../../shared/theme/typography/app_text_type.dart';
import '../../../shared/theme/typography/app_text_widget.dart';

class AppCategoryPill extends StatelessWidget {
  const AppCategoryPill({super.key, required this.title, required this.onTap, required this.isSelected});

  final String title;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.textRed : Colors.transparent,
            borderRadius: BorderRadiusGeometry.circular(32),
            border: Border.fromBorderSide(BorderSide(color: AppColors.textRed))
        ),
        child: AppTextWidget(text: title, type: AppTextType.title, color: isSelected ? AppColors.textOnPrimary : AppColors.textRed).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
