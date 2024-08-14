// ui/news_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
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
                      ? Image.network(article.urlToImage)
                      : null,
                  onTap: () {},
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
            return Center(child: Text('Failed to load news: ${state.message}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
