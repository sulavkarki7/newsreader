import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsreader/bloc/news_bloc.dart';
import 'package:newsreader/bloc/news_event.dart';
import 'package:newsreader/ui/bookmarks_page.dart';
import 'package:newsreader/ui/news_page.dart';
import 'package:newsreader/ui/news_search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.blueAccent[100],
        title: const Text('News Reader App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarksPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          BlocProvider.of<NewsBloc>(context).add(LoadNews(category: 'general'));
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsPage(category: 'general'),
                    ),
                  );
                },
                child: const Text('General News'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const NewsPage(category: 'technology'),
                    ),
                  );
                },
                child: const Text('Technology News'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsPage(category: 'sports'),
                    ),
                  );
                },
                child: const Text('Sports News'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
