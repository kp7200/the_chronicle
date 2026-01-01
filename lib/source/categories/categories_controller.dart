import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:the_chronicle/core/utils/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/constants/api_constants.dart';
import '../dashboard/models/top_headlines_model.dart';

class CategoriesController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  late ScrollController scrollController;
  late Dio dio;
  final selectedIndex = Rx<int>(0);

  final categories = const [
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  final articles = <Article>[].obs;
  final isLoading = false.obs;

  int page = 1;
  bool hasMore = true;
  String currentCategory = 'business';

  @override
  void onInit() {
    super.onInit();
    _initDio();
    _initTabs();
    _initScroll();
    fetchArticles(isInitial: true);
  }

  void _initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.topHeadlinesByCategory,
        queryParameters: {
          'category' : currentCategory.toLowerCase(),
          'apiKey' : dotenv.env['API_KEY'],
        },
      ),
    );
  }

  void _initTabs() {
    tabController = TabController(
      length: categories.length,
      vsync: this,
    );

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentCategory = categories[tabController.index];
        fetchArticles(isInitial: true);
      }
    });
  }

  void _initScroll() {
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100 &&
          !isLoading.value &&
          hasMore) {
        fetchArticles();
      }
    });
  }

  Future<void> fetchArticles({bool isInitial = false}) async {
    if (isLoading.value) return;

    logger.e("Fetchinggggggggggggggggggg");

    if (isInitial) {
      page = 1;
      hasMore = true;
      articles.clear();
    } else {
      if (!hasMore) return;
      page++;
    }

    isLoading.value = true;

    try {
      final response = await dio.get(
        ApiConstants.topHeadlinesByCategory,
        queryParameters: {
          'category': currentCategory,
          'country': 'us',
          'page': page,
          'pageSize': 10,
        },
      );

      final model = TopHeadlinesModel.fromJson(response.data);
      final newArticles = model.articles;

      articles.addAll(newArticles);

      /*if (newArticles.length < 10) {
        hasMore = false;
      }*/
      if (model.totalResults != null &&
          articles.length >= model.totalResults!) {
        hasMore = false;
      }
    } on DioException catch (e) {
      if(e.response?.statusCode == 429){
        Get.snackbar("Too Many Requests", "You have made too many requests recently. Developer accounts are limited to 100 requests over a 24 hour period (50 requests available every 12 hours). Please upgrade to a paid plan if you need more requests.");
      }
      Get.snackbar("Failed load News", "Please try again after sometime or contact developer");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openInBrowser(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
