import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsreader/bloc/news_bloc.dart';
import 'package:newsreader/repos/news_repository.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox(
      'offlineArticles'); // Open a Hive box for storing offline articles

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(newsRepository: NewsRepository())
            ..add(FetchNews(
                category:
                    'general')), // Fetch initial news with 'general' category
        ),
      ],
      child: MaterialApp(
        title: 'News Reader',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const HomeScreen(),
        routes: {
          '/details': (context) => const NewsDetailsScreen(),
          '/offline': (context) => const OfflineArticlesScreen(),
        },
      ),
    );
  }
}
