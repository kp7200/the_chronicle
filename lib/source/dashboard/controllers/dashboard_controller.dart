import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:the_chronicle/core/utils/app_logger.dart';
import 'package:the_chronicle/shared/constants/api_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/top_headlines_model.dart';

class DashboardController extends GetxController{
  final isLoading  = false.obs;
  final selectedIndex = Rx<int>(0);
  String selectedCategory = '';

  //dio object
  final Dio dio = Dio();

  //model object
  TopHeadlinesModel topHeadlinesModel = TopHeadlinesModel(articles: []);
  final articles = RxList<Article>();

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['category'] != null){
      selectedCategory = args['category'];
    }
    getTopHeadLines();
    super.onInit();
  }

  Future<void> getTopHeadLines()async {
    try{
      final Response apiResponse;
      isLoading.value = true;

      logger.i("Function called");
      logger.i("category: ${selectedCategory.toLowerCase()}");

      apiResponse = await dio.get(ApiConstants.topHeadlinesByCategory,
          queryParameters: {
        'category' : selectedCategory.toLowerCase(),
        'apiKey' : dotenv.env['API_KEY'],
      });

      logger.d(apiResponse.requestOptions.path);

      if(apiResponse.statusCode == 200){
        logger.i("Response Success");
        logger.d("Response: ${apiResponse.data.toString()}");
        topHeadlinesModel = TopHeadlinesModel.fromJson(apiResponse.data);
        logger.d("Response: ${topHeadlinesModel.toJson()}");
        articles.value = topHeadlinesModel.articles ?? [];
      }
    }
    on DioException catch(e){
      if(e.response?.statusCode == 429){
        Get.snackbar("Too Many Requests", "You have made too many requests recently. Developer accounts are limited to 100 requests over a 24 hour period (50 requests available every 12 hours). Please upgrade to a paid plan if you need more requests.");
      }
      logger.e("asdfghjk::: $e");
      Get.snackbar("Failed load News", "Please try again after sometime or contact developer");
    }
    finally{
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

}