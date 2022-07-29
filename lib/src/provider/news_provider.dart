import 'package:flutter/cupertino.dart';

import '../model/news.dart';
import '../model/news_res.dart';

class NewsProvider with ChangeNotifier {
  String author = "";
  String title = "";
  String description = "";
  String urlToImage = "";
  DateTime publishedAt = DateTime.now();
  String content = "";
  String sourceId = "";
  String sourceName = "";
  final allNews = <News>[];
  data({required NewsRes? res}) async {
    for (var element in res!.articles) {
      author = element.author;
      title = element.title;
      description = element.description;
      urlToImage = element.urlToImage;
      publishedAt = element.publishedAt;
      content = element.content;
      sourceId = element.source.id;
      sourceName = element.source.name;
    }
    allNews.addAll(res.articles);
  }

  String get newsAuthor => author;

  String get newsTitle => title;

  String get newsDescription => description;

  String get newsUrlToImage => urlToImage;

  DateTime get newsPublishedAt => publishedAt;

  String get newsContent => content;

  String get newsSourceId => sourceId;

  String get newsSourceName => sourceName;
}
