import 'package:flutter/material.dart';

import 'Rabbit.dart';

class StatelessSampleWidget extends StatelessWidget {
  String _title;
  Rabbit _rabbit;

  StatelessSampleWidget({String title, Rabbit rabbit}) {
    this._title = title;
    this._rabbit = rabbit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Container(
        child: Center(
            child: Text(_rabbit.name + "/" + _rabbit.rabbitState.toString(),
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}
