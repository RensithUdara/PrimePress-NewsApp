import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:infosphere/models/top_headlines.dart';
import 'package:infosphere/view/discover_screen.dart';

class Headlines {
  Future<TopHeadlines> getTopHeadlines() async {
    final endpoint =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=1f6445eb6a1f41e19187b956f0b12296";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return TopHeadlines.fromJson(body);
    } else {
      throw ("something went wrongs");
    }
  }

  Future<TopHeadlines> getCategoryNews(String category) async {
    final endpoind =
        "https://newsapi.org/v2/everything?q=$category&apiKey=1f6445eb6a1f41e19187b956f0b12296";
    final response = await http.get(Uri.parse(endpoind));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return TopHeadlines.fromJson(body);
    }
    throw ("something went wrong");
  }
}
