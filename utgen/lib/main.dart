import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sipconfig.dart';

void main() => runApp(Utgen());

class Utgen extends StatelessWidget {
  const Utgen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTGen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageWidget(key: Key("HomePageWidget")),
      // home: CupertinoPage(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController(text: '6060');
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // backgroundColor: Colors.red,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black38,
                tabs: [
                  Tab(
                    text: 'Settings',
                  ),
                  Tab(
                    text: 'Scenario',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SipConfig(),
                    // newMethod(),
                    Text(
                      'Tab View 2',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding newMethod() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'SIP Config',
          ),
          Divider(color: Colors.transparent),
          TextFormField(
            controller: textController1,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Scenario File Path',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Input Scenario File path';
              }

              return null;
            },
          ),
          Divider(color: Colors.transparent),
          TextFormField(
            controller: textController2,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'SIP Local FAddress',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
          ),
          Divider(color: Colors.transparent),
          TextFormField(
            controller: textController3,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'SIP Port',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          Divider(color: Colors.transparent),
          Text(
            'RTP Config',
          ),
          TextFormField(
            controller: textController4,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'RTP Local IP Address',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
          ),
          TextFormField(
            controller: textController5,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'RTP Port',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
          )
        ],
      ),
    );
  }
}
