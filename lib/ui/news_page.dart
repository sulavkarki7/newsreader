import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsreader/bloc/news_event.dart';
import 'package:newsreader/bloc/news_state.dart';
import 'package:newsreader/ui/article_detail_page.dart';
import 'package:newsreader/ui/bookmarks_page.dart';
import '../bloc/news_bloc.dart';

class NewsPage extends StatelessWidget {
  final String category;

  const NewsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News - $category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              BlocProvider.of<NewsBloc>(context).add(LoadSavedArticles());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarksPage()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<NewsBloc>(context).add(LoadNews(category: category));
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.description),
                    leading: article.urlToImage != null
                        ? Image.network(article.urlToImage!)
                        : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticleDetailPage(article: article),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {
                        BlocProvider.of<NewsBloc>(context)
                            .add(SaveArticle(article: article));
                      },
                    ),
                  );
                },
              );
            } else if (state is NewsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load news: ${state.message}'),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<NewsBloc>(context)
                            .add(LoadNews(category: category));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
