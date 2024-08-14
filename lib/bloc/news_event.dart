part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

class LoadNews extends NewsEvent {
  final String category;
  LoadNews({required this.category});
}

class SaveArticle extends NewsEvent {
  final NewsArticle article;
  SaveArticle({required this.article});
}

class LoadSavedArticles extends NewsEvent {}
