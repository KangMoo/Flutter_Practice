import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BBANTO',
      home: Grade(),
    );
  }
}

class Grade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[800],
      appBar: AppBar(
        title: Text('BBANTO'),
        backgroundColor: Colors.amber[700],
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text('Name',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('BBANTO',
            style: TextStyle(
              color: Colors.white,
              letterSpacing:  2,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
          ),
      ),
    );
  }
}
