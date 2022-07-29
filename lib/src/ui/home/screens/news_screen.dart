import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/news.dart';

class NewsScreen extends StatefulWidget {
  final News? data;
  NewsScreen(this.data, {Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(widget.data!.urlToImage),
              height: 200.0,
              width: double.infinity,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Headline',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              widget.data!.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Description',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              widget.data!.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      )),
    );
  }

  _appBarTitle() => RichText(
        text: const TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Social',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway-Medium',
                fontSize: 30.0,
              ),
            ),
            TextSpan(
              text: ' X',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway-Medium',
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      );
}
