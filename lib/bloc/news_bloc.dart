import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsreader/models/news_article%20.dart';
import 'package:newsreader/repos/news_repository.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  List<Article> bookmarkedArticles = [];

  NewsBloc({required this.newsRepository}) : super(NewsLoading()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await newsRepository.fetchNews(event.category);
        emit(NewsLoaded(articles: articles));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });

    on<SearchNews>((event, emit) async {
      emit(NewsLoading());
      try {} catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });

    on<LoadSavedArticles>((event, emit) {
      emit(NewsbooksmarksLoaded(bookmarkedArticles: bookmarkedArticles));
    });

    on<SaveArticle>((event, emit) {
      bookmarkedArticles.add(event.article);
      emit(NewsbooksmarksLoaded(bookmarkedArticles: bookmarkedArticles));
    });

    on<RemoveBookmark>((event, emit) {
      bookmarkedArticles
          .removeWhere((article) => article.title == event.article.title);
      emit(NewsbooksmarksLoaded(bookmarkedArticles: bookmarkedArticles));
    });
    on<ClearAllBookmarks>((event, emit) {
      bookmarkedArticles.clear();
      emit(NewsbooksmarksLoaded(bookmarkedArticles: bookmarkedArticles));
    });
  }
}
