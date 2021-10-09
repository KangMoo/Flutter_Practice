import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SipConfig extends StatefulWidget {
  const SipConfig({Key? key}) : super(key: key);
  @override
  SipConfigState createState() => SipConfigState();
}

class SipConfigState extends State<SipConfig> {
  String? _scenarioFile;
  String? targetAddr;
  String localIp = '127.0.0.1';
  int localport = 6060;
  TextEditingController scenarioFilePathController = TextEditingController();
  TextEditingController targetAddrController = TextEditingController();
  TextEditingController sipIpController = TextEditingController();
  TextEditingController sipPortController = TextEditingController(text: '6060');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'SIP Config',
            ),
            Divider(color: Colors.transparent),
            TextFormField(
              controller: scenarioFilePathController,
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
              controller: targetAddrController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'SIP Target Address',
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
              controller: targetAddrController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'SIP IP',
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
              controller: sipPortController,
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
          ],
        ),
      ),
    );
  }
}
