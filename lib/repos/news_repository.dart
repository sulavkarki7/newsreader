import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newsreader/models/news_article%20.dart';
import 'package:newsreader/repos/news_response.dart';

class NewsRepository {
  final String apiKey = 'your_api_key_here';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchNews(String category) async {
    final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?category=$category&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final newsResponse = NewsResponse.fromJson(jsonResponse);
      return newsResponse.articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
