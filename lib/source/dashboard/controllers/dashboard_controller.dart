import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:the_chronicle/core/utils/app_logger.dart';
import 'package:the_chronicle/shared/constants/api_constants.dart';
import '../models/top_headlines_model.dart';

class DashboardController extends GetxController{
  final isLoading  = false.obs;

  //dio object
  final Dio dio = Dio();

  //model object
  TopHeadlinesModel topHeadlinesModel = TopHeadlinesModel(articles: []);
  final articles = RxList<Article>();
  String selectedCategory = '';

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
    catch(e){
      logger.e("asdfghjk::: $e");
    }
    finally{
      isLoading.value = false;
    }
  }
}