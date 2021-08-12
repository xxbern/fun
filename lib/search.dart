import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchCtl = TextEditingController();

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _onSearch(searchCtl.text));
  }

  void _onSearch(String value) {
    setState(() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(searchCtl.text),
        backgroundColor: Colors.blue,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var keyword = ModalRoute.of(context)!.settings.arguments as String;

    searchCtl.text = keyword;

    return Scaffold(
      appBar: AppBar(
        title: CupertinoTextField(
          textInputAction: TextInputAction.search,
          onSubmitted: _onSearch,
          controller: searchCtl,
        ),
        actions: [
          IconButton(
            tooltip: "search",
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () => _onSearch(searchCtl.text),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
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
              child: Container(
                color: Colors.deepPurpleAccent,
                width: 200,
                height: 150,
                alignment: Alignment.center,
                child: Text(
                  "Card",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              )),
          Text(searchCtl.text)
        ],
      ),
    );
  }
}
