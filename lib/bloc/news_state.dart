part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;
  NewsLoaded({required this.articles});

  @override
  List<Object> get props => [articles];
}

class NewsError extends NewsState {
  final String message;
  NewsError({required this.message});

  @override
  List<Object> get props => [message];
}

class SavedArticlesLoaded extends NewsState {
  final List<NewsArticle> savedArticles;

  SavedArticlesLoaded({required this.savedArticles});

  @override
  List<Object> get props => [savedArticles];
}
