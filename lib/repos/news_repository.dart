// repository/news_repository.dart
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:newsreader/models/news_article%20.dart';

class NewsRepository {
  final Dio _dio = Dio();

  Future<List<NewsArticle>> fetchNews(String category) async {
    final response = await _dio.get('https://newsapi.org/v2/top-headlines',
        queryParameters: {'category': category, 'apiKey': 'YOUR_NEWSAPI_KEY'});

    final List articlesJson = response.data['articles'];
    return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
  }

  Future<void> saveArticle(NewsArticle article) async {
    final box = await Hive.openBox<NewsArticle>('saved_articles');
    box.add(article);
  }

  Future<List<NewsArticle>> getSavedArticles() async {
    final box = await Hive.openBox<NewsArticle>('saved_articles');
    return box.values.toList();
  }
}
