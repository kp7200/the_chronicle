import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:the_chronicle/core/route_manager/route_constants.dart';
import 'package:the_chronicle/core/utils/extensions.dart';
import '../../../shared/constants/image_constants.dart';
import '../../../shared/constants/string_constants.dart';
import '../../../shared/theme/app_colors.dart';
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
        centerTitle: true,
        title: AppTextWidget(text: StringConstants.appName, type: AppTextType.headline,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          Row(
            children: [
              AppTextWidget(text: "For", type: AppTextType.display,),
              const SizedBox(width: 4,),
              AppTextWidget(text: "You!", type: AppTextType.display, color: AppColors.textRed,),
            ],
          ),
          AppTextWidget(text: "Discover ${StringConstants.appName}'s recommendations", color: Theme.of(context).disabledColor,),
          const SizedBox(height: 15,),
          Obx(() {
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.selectedIndex.value = index;
                        Get.toNamed(RouteConstants.detailsScreenFromDashboard);
                      },
                      child: Card(
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //image
                            Hero(
                              tag: controller.articles[index].title.toString(),
                              child: Card(
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
                                    AppTextWidget(text: "${controller.articles[index].publishedAt?.formatDate()}", type: AppTextType.caption,),
                                  ],
                                ),
                                IconButton(onPressed: () => controller.openInBrowser(controller.articles[index].url.toString()), icon: SvgPicture.asset(ImageConstants.externalLinkIcon, height: 22, width: 22, colorFilter: ColorFilter.mode(Theme.of(context).primaryColorDark, BlendMode.srcATop),),),
                              ],
                            ).paddingSymmetric(horizontal: 8),
                            SizedBox(height: 8,)
                          ],
                        ),
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
