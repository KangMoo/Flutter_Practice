// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_practice/cupertino_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("Hello My Name is Victor");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HelloPage("Hello World", key: Key("HelloPage")),
      // home: CupertinoPage(),
    );
  }
}

class HelloPage extends StatefulWidget {
  final String title;

  const HelloPage(this.title, {Key? key}) : super(key: key);

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  String _message = 'Hello World2';
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: _changeMessage),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message, style: TextStyle(fontSize: 30)),
            Text('$_counter', style: TextStyle(fontSize: 30)),
            ElevatedButton(
                child: Text('화면 이동'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CupertinoPage(key: Key("CupertinoPage"))));
                })
          ],
        )));
  }

  void _changeMessage() {
    setState(() {
      _message = "Hello World";
      _counter++;
    });
  }
}
