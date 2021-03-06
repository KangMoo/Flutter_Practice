import 'package:flutter/material.dart';
import 'package:flutter_practice/Rabbit.dart';
import 'package:flutter_practice/Stateless_Sample_Widget.dart';

// 앱 시작 부분
void main() {
  runApp(MyApp());
}

// 시작 클래스. 머티리얼 디자인 앱 생성
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StatelessSampleWidget(
        title: "Stateless Sample Widget",
        rabbit: Rabbit(name:"만렙토끼", state:RabbitState.SLEEP)
      ),
    );
  }
}

// 시작 클래스가 실제로 표시하는 클래스. 카운터 앱 화면
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// 위 MyHomePage 클래스의 상태를 나타내는 State클래스
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // 화면에 표시할 상태값인 카운터 숫저

  // counter 변수를 1 증가시키고 화면을 다시 그리는 메서드
  void _incrementCounter() {
    setState(() { // 화면을 다시 그리는 메서
      _counter++;
    });
  }

  // 화면에 UI를 그리는 메서드. 그려질 위젯을 반환
  @override
  Widget build(BuildContext context) {
    return Scaffold(  // 머테리얼 디자인 기본 뼈대 위젯
      appBar: AppBar( // 상단 앱바
        title: Text(widget.title),
      ),
      body: Center( // 표시할 내용
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter', // _counter 변수를 표시
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // 클릭 시 _incrementCounter() 메서드 실행
        tooltip: 'Increment',
        child: Icon(Icons.add), // 상단 앱바
      ),
    );
  }
}
