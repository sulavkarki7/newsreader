import 'package:newsreader/models/news_article%20.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;

  NewsLoaded({required this.articles});
}

class NewsError extends NewsState {
  final String message;

  NewsError({required this.message});
}

class NewsbooksmarksLoaded extends NewsState {
  final List<Article> bookmarkedArticles;

  NewsbooksmarksLoaded({required this.bookmarkedArticles});
}
