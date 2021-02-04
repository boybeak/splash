import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:splash/api.dart';
import 'package:splash/model/user.dart';
import 'package:splash/page/collection_list.dart';
import 'package:splash/page/detail.dart';
import 'package:splash/page/hello.dart';
import 'package:splash/page/photo_list.dart';
import 'package:splash/page/profile.dart';
import 'package:splash/theme.dart';
import 'package:splash/widget/photo_card.dart';

import 'model/photo.dart';

bool isDownloaderInitialized = false;

void main() {
  initDownloader();
  runApp(App());
}

void initDownloader() async {
  if (isDownloaderInitialized) {
    return;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await {
    FlutterDownloader.initialize(debug: true),
    isDownloaderInitialized = true
  };
}

class App extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      // home: MainPage(title: 'Flutter Demo Home Page'),
      home: HelloPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'main':
            return MaterialPageRoute(
                builder: (context) => MainPage(
                      title: "Splash",
                    ));
          case 'detail':
            print("arguments=${settings.arguments}");
            Photo photo = (settings.arguments as Map)['photo'];
            return MaterialPageRoute(
                builder: (context) => DetailPage(
                      photo: photo,
                    ));
          case 'user':
            User user = (settings.arguments as Map)['user'];
            return MaterialPageRoute(builder: (context) => UserPage(user));
          default:
            return MaterialPageRoute(builder: (context) => HelloPage());
        }
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  final tabs = ['EDITORIAL', 'COLLECTION'];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PhotoListPage(),
          CollectionListPage()
        ],
      ),
    );
  }
}
