import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newsreader/models/news_article%20.dart';
import 'package:newsreader/repos/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;
  NewsBloc(this.repository, {required NewsRepository newsRepository})
      : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<SaveArticle>(_onSaveArticle);
    on<LoadSavedArticles>(_onLoadSavedArticles);
  }

  FutureOr<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final articles = await repository.fetchNews(event.category);
      emit(NewsLoaded(articles: articles));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  FutureOr<void> _onSaveArticle(
      SaveArticle event, Emitter<NewsState> emit) async {
    await repository.saveArticle(event.article);
  }

  FutureOr<void> _onLoadSavedArticles(
      LoadSavedArticles event, Emitter<NewsState> emit) async {
    final savedArticles = await repository.getSavedArticles();
    emit(SavedArticlesLoaded(savedArticles: savedArticles));
  }
}
