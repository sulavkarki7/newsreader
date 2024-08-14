// models/news_article.dart
import 'package:hive/hive.dart';

// part 'news_article.g.dart';

@HiveType(typeId: 0)
class NewsArticle extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String urlToImage;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final String url;

  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.content,
    required this.url,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
