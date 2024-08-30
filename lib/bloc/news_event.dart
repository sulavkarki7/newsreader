import 'package:newsreader/models/news_article%20.dart';

abstract class NewsEvent {}

class LoadNews extends NewsEvent {
  final String category;

  LoadNews({required this.category});
}

class SearchNews extends NewsEvent {
  final String query;

  SearchNews({required this.query});
}

class LoadSavedArticles extends NewsEvent {}

class SaveArticle extends NewsEvent {
  final Article article;

  SaveArticle({required this.article});
}

class RemoveBookmark extends NewsEvent {
  final Article article;

  RemoveBookmark({required this.article});
}

class ClearAllBookmarks extends NewsEvent {}
