import 'package:dio/dio.dart';
import 'package:test_app/app/core/utils/constants.dart';
import '../../../data/models/news_model/news_model.dart';
import '../../../data/providers/api_provider.dart';

class NewsProvider extends ApiProvider {
  Future<NewsModel> getAllNews() async {
    Response res = await Dio().get(Constants.newsApiGET);
    return NewsModel.fromJson(res.data);
  }
}
