import 'package:know_more/Models/Articles.dart';
import 'dart:convert';

NewsResponse newsResponseFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

class NewsResponse {
  String? status;

  int? totalResults;

  List<Article> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json["status"],
      totalResults: json["totalResults"],
      articles:
          List<Article>.from(json["articles"].map((e) => Article.fromJson(e)))
              .toList(),
    );
  }
}
