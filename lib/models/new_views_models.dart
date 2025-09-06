import 'package:infosphere/models/categrious__news_model.dart';
import 'package:infosphere/models/top_headlines.dart';
import 'package:infosphere/services/topheadlines_api.dart';

class NewsviewModel {
  final repo = Headlines();

  Future<TopHeadlines> getTopHeadlines() async {
    final response = await repo.getTopHeadlines();
    return response;
  }

  Future<TopHeadlines> getCategoryNews(String category) async {
    final response = await repo.getCategoryNews(category);
    return response;
  }
}
