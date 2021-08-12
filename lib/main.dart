import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage('Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        "/search": (BuildContext context) => new SearchPage(),
        "/history": (BuildContext context) => new SearchPage(),
        "/settings": (BuildContext context) => new SearchPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("selected $_selectedIndex"),
      //   backgroundColor: Colors.blue,
      // ));
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _incrementCounter() async {
    http.Response response = await goBaidu();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      // htmlDom.Document parse = htmlDom.Document.html(response.body);
      // // var body = parse.getElementById("00001.jpg");
      // var body = parse.getElementById("main");
    });
  }

  goBaidu() {
    // return http.get(new Uri(scheme: "https", host: "18comic.art", path: '/photo/264793'));
    return http.get(new Uri(scheme: "https", host: "www.coolapk.com"));
  }

  void _onSearch(String keyword) async {
    await Navigator.of(context).pushNamed('/search', arguments: keyword);
  }

  @override
  Widget build(BuildContext context) {
    var card = Card(
        color: Colors.blueAccent,
        //z轴的高度，设置card的阴影
        elevation: 20.0,
        //设置shape，这里设置成了R角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
        clipBehavior: Clip.antiAlias,
        semanticContainer: false,
        child: Stack(
          fit: StackFit.expand,
          // textDirection: TextDirection.ltr,
          children: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("hello"),
                  backgroundColor: Colors.blue,
                ));
              },
              child: Image.network(
                "https://cdn-msp.18comic.art/media/albums/257845_3x4.jpg?v=1628772520",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 10,
              child: Text(
                "不可思议的沉默",
                textWidthBasis: TextWidthBasis.parent,
                style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    fontSize: 13),
              ),
            )
          ],
        ));
    Widget renderBody() {
      var arr = [
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.7,
          ),
          children: [card, card, card],
        ),
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 12),
          children: [
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card,
            card
          ],
        ),
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.7,
          ),
          children: [card, card, card, card],
        ),
      ];
      return PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: arr,
      );
    }

    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: CupertinoTextField(
              textInputAction: TextInputAction.search, onSubmitted: _onSearch),
          actions: <Widget>[
            IconButton(
              tooltip: "History",
              icon: const Icon(
                Icons.history,
              ),
              onPressed: () {},
            ),
            PopupMenuButton<Text>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text(
                      "localization.demoNavigationRailFirst",
                    ),
                  ),
                  PopupMenuItem(
                    child: Text(
                      "localization.demoNavigationRailSecond",
                    ),
                  ),
                  PopupMenuItem(
                    child: Text(
                      "localization.demoNavigationRailThird",
                    ),
                  ),
                ];
              },
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: renderBody(),

      //     children: <Widget>[
      //       Text(
      //         "",
      //       ),
      //       Text(
      //         'loading',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //       Image.network(
      //           "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimages.h128.com%2Fupload%2F201906%2F28%2F201906281538313505.jpg%3Fx-oss-process%3Dimage%2Fauto-orient%2C1%2Fresize%2Cm_fill%2Cw_373%2Ch_767%2Fquality%2Cq_100%2Fformat%2Cjpg&refer=http%3A%2F%2Fimages.h128.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631116857&t=cddf4d706016926d7dddfbc1e9aa3f1e")
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_rounded),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Comic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Book',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: _onItemTapped,
      ),
    );
  }
}
