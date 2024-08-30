import 'package:newsreader/models/news_article%20.dart';

class NewsResponse {
  final List<Article> articles;

  NewsResponse({required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var articlesJson = json['articles'] as List;
    List<Article> articleList =
        articlesJson.map((i) => Article.fromJson(i)).toList();
    return NewsResponse(articles: articleList);
  }
}
