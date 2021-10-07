import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppBar',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snack Bar'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext ctx) {
        return Center(
          child: OutlinedButton(
            child: Text(
              'Show me',
              style: TextStyle(color: Colors.red),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(16.0),
              primary: Colors.red,
              textStyle: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Hello'),
              ));
            },
          ),
          // child: TextButton(
          //   child: Text(
          //     'Show me',
          //     style: TextStyle(color: Colors.red),
          //   ),
          //   style: TextButton.styleFrom(
          //     padding: EdgeInsets.all(16.0),
          //     primary: Colors.red,
          //     textStyle: TextStyle(fontSize: 20),
          //   ),
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       content: Text('Hello'),
          //     ));
          //   },
          // ),
        );
      }),
    );
  }
}
