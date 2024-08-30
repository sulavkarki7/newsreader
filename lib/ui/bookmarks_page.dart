import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsreader/bloc/news_event.dart';
import 'package:newsreader/bloc/news_state.dart';
import 'package:newsreader/models/news_article%20.dart';

import 'package:newsreader/ui/article_detail_page.dart';
import '../bloc/news_bloc.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Articles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showClearBookmarksDialog(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsbooksmarksLoaded) {
            if (state.bookmarkedArticles.isEmpty) {
              return const Center(
                child: Text('No bookmarked articles yet.'),
              );
            }
            return ListView.builder(
              itemCount: state.bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = state.bookmarkedArticles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  leading: article.urlToImage != null
                      ? Image.network(article.urlToImage!)
                      : const Icon(Icons.image_not_supported), // Placeholder
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<NewsBloc>(context)
                          .add(RemoveBookmark(article: article));
                    },
                  ),
                  onTap: () {
                    _navigateToArticleDetail(context, article);
                  },
                );
              },
            );
          } else if (state is NewsError) {
            return Center(
              child: Text('Failed to load bookmarks: ${state.message}'),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _navigateToArticleDetail(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailPage(article: article),
      ),
    );
  }

  void _showClearBookmarksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Bookmarks'),
        content: const Text('Are you sure you want to clear all bookmarks?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<NewsBloc>(context).add(ClearAllBookmarks());
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
