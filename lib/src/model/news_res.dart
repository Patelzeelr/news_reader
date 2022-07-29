import 'dart:convert';

import 'news.dart';

NewsRes newsResFromJson(String str) => NewsRes.fromJson(json.decode(str));

String newsResToJson(NewsRes data) => json.encode(data.toJson());

class NewsRes {
  NewsRes({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<News> articles;

  factory NewsRes.fromJson(Map<String, dynamic> json) => NewsRes(
        status: json["status"],
        totalResults: json["totalResults"],
        articles:
            List<News>.from(json["articles"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<News>.from(articles.map((x) => x.toJson())),
      };
}
