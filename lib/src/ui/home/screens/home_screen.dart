import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/news_api.dart';
import '../../../model/firebase_service.dart';
import '../../../model/news.dart';
import '../../../model/news_res.dart';
import '../../../provider/news_provider.dart';
import '../../auth/screens/create_account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsRes? newsData;
  bool _isLoad = false;
  final searchController = TextEditingController();

  late List<News> news;
  String query = '';

  _getData() async {
    setState(() {
      _isLoad = true;
    });
    newsData = await NewsAPI.getNews(context);
    Provider.of<NewsProvider>(context, listen: false).data(res: newsData);
    setState(() {
      _isLoad = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
    news = Provider.of<NewsProvider>(context, listen: false).allNews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
        title: TextField(
          onChanged: searchBook,
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search in feed',
            hintStyle: TextStyle(
                color: Colors.blue,
                fontFamily: 'Raleway-Medium',
                fontSize: 20.0),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            onPressed: () async {
              _showLogOutDialog(
                  context, 'Are you sure you want to Logout?', 'ok', () async {
                FirebaseService service = FirebaseService();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                await service.signOutFromGoogle();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateAccountScreen()),
                    (route) => false);
              });
            },
          ),
        ],
      ),
      body: _isLoad
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : news.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      final data = news[index];
                      return Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        shadowColor: Colors.grey,
                        elevation: 6.0,
                        child: _cardDetail(data),
                      );
                    },
                  ),
                )
              : const Text(
                  'No Data',
                  style: TextStyle(color: Colors.blue),
                ),
    );
  }

  void searchBook(String query) {
    final news =
        Provider.of<NewsProvider>(context, listen: false).allNews.where((news) {
      final titleLower = news.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.news = news;
    });
  }

  _cardDetail(News data) => ListTile(
        title: Row(
          children: [
            Text(
              DateFormat.yMMMd().format(data.publishedAt),
              style: const TextStyle(
                  color: Colors.grey, fontFamily: 'Raleway-Medium'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                data.source.name,
                style: const TextStyle(
                    color: Colors.grey, fontFamily: 'Raleway-Bold'),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                    color: Colors.blue, fontFamily: 'Raleway-Bold'),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  data.description,
                  style: const TextStyle(
                      color: Colors.blue, fontFamily: 'Raleway-Medium'),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: NetworkImage(data.urlToImage),
          ),
        ),
      );

  _showLogOutDialog(BuildContext context, String message, String buttonLabel,
          Function() onPressButtonOk) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Social X'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(child: Text(buttonLabel), onPressed: onPressButtonOk),
          ],
        ),
      );
}
