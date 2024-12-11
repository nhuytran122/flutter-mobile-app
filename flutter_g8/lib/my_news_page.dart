import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/news.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyNewsPage extends StatefulWidget {
  const MyNewsPage({super.key});

  @override
  State<MyNewsPage> createState() => _MyNewsPageState();
}

class NewsProvider extends ChangeNotifier {
  List<NewsModel> list = [];

  void getList() async {
    String apiURL = "";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var newsListObject = jsonObject['articles'] as List;
    list = newsListObject.map((e) {
      return NewsModel(author: e['author'], title: e['title']);
    }).toList();
    notifyListeners();
  }
}

class _MyNewsPageState extends State<MyNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterNews'),
      ),
      body: Center(
        child: Column(
          children: [
            // Image(image: ),
          ],
        ),
      ),
    );
  }
}

void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(create: (context) => NewsProvider()),
      ],
      child: MyNewsPage(
        home: MyNewsPage(),
      ),
    )
  );
}
