import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/string_constants.dart';
import '../../../shared/theme/typography/app_text_type.dart';
import '../../../shared/theme/typography/app_text_widget.dart';
import '../controllers/dashboard_controller.dart';


class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppTextWidget(text: StringConstants.appName, type: AppTextType.display,),
        actions: [
          IconButton(onPressed: (){controller.getTopHeadLines();}, icon: Icon(Icons.refresh))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          AppTextWidget(text: "For You", type: AppTextType.headline,),
          AppTextWidget(text: "Discover ${StringConstants.appName}'s recommendations", color: Theme.of(context).disabledColor,),
          const SizedBox(height: 15,),
          Obx(() {
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //image
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                child: controller.articles[index].urlToImage != null
                                    ? Image.network(
                                  controller.articles[index].urlToImage!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                  const SizedBox(width: double.infinity, height: 180, child: Icon(Icons.broken_image, size: 36,)),
                                )
                                    : const SizedBox(
                                  width: double.infinity,
                                  height: 180,
                                  child: Icon(Icons.image_not_supported, size: 36,),
                                )
                            ),
                          ),
                          //banner
                          /*Container(
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.1)
                            ),
                            child: Row(
                              children: [
                                AppTextWidget(text: "${controller.articles[index].source?.name}", type: AppTextType.label,)
                              ],
                            ).paddingOnly(left: 8),
                          ),*/
                          const SizedBox(height: 15,),
                          //article title
                          AppTextWidget(text: controller.articles[index].title.toString(), type: AppTextType.title, maxLines: 2).paddingSymmetric(horizontal: 8),
                          // const SizedBox(height: 10,),
                          //author and date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(text: controller.articles[index].author ?? 'No Author', type: AppTextType.caption, color: Theme.of(context).primaryColorDark,),
                                  AppTextWidget(text: "${controller.articles[index].publishedAt?.year.toString()}", type: AppTextType.caption,),
                                ],
                              ),
                              IconButton(onPressed: (){}, icon: Icon(Icons.link, color: Theme.of(context).primaryColorDark,)),
                            ],
                          ).paddingSymmetric(horizontal: 8),
                          SizedBox(height: 8,)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10,);
                  },
                  itemCount: controller.articles.length
              ),
            );
          },),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
