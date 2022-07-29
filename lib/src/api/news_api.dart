import 'package:news_reader/src/provider/news_provider.dart';
import 'package:provider/provider.dart';

import '../model/news_res.dart';
import 'base_api.dart';

class NewsAPI {
  static Future<NewsRes> getNews(context) async {
    final response = await BaseAPI.apiGet(
        url:
            "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=2860e35344d448ff8189fdaca7a62c3f");
    Provider.of<NewsProvider>(context, listen: false)
        .data(res: newsResFromJson(response.body));
    return newsResFromJson(response.body);
  }
}
