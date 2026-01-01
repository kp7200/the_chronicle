import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:the_chronicle/core/utils/extensions.dart';
import 'package:the_chronicle/shared/theme/app_colors.dart';
import 'package:the_chronicle/shared/theme/typography/app_text_type.dart';
import 'package:the_chronicle/shared/theme/typography/app_text_widget.dart';
import 'package:the_chronicle/source/dashboard/controllers/dashboard_controller.dart';
import '../../shared/constants/image_constants.dart';

class DetailsScreenFromDashboard extends GetView<DashboardController> {
  const DetailsScreenFromDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = controller.articles[controller.selectedIndex.value];
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: Get.width / 1.5,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Hero(
                  tag: articles.title.toString(),
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.zero,
                    child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                        child: articles.urlToImage != null
                            ? Image.network(
                          articles.urlToImage!,
                          fit: BoxFit.fill,
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
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  AppTextWidget(text: "${articles.title}", type: AppTextType.title, maxLines: 3,),
                  const SizedBox(height: 10,),
                  AppTextWidget(text: "${articles.description}", type: AppTextType.label, maxLines: 5,),
                  AppTextWidget(text: "${articles.content}", type: AppTextType.body, maxLines: 7,),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(text: articles.author ?? 'No Author', type: AppTextType.label),
                          AppTextWidget(text: articles.source?.name ?? '', type: AppTextType.caption),
                          AppTextWidget(text: "${articles.publishedAt?.formatDate()}", type: AppTextType.caption, color: AppColors.secondary,)
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          controller.openInBrowser(articles.url ?? '');
                        },
                        icon: SvgPicture.asset(ImageConstants.externalLinkIcon, colorFilter: ColorFilter.mode(Theme.of(context).primaryColorDark, BlendMode.srcATop),),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
