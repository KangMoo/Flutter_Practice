import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
      home: const HomePageWidget(key: Key("UTGen")),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ipExp = RegExp(r'/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\z/');
  TextEditingController scenarioFilePathController = TextEditingController();
  TextEditingController targetAddrController = TextEditingController();
  TextEditingController sipIpController = TextEditingController();
  TextEditingController sipPortController = TextEditingController(text: '6060');
  TextEditingController mediaIpController =
      TextEditingController(text: '127.0.0.1');
  TextEditingController mediaPortController = TextEditingController(text: '0');
  TextEditingController minRtpPortController = TextEditingController(text: '0');
  TextEditingController maxRtpPortController = TextEditingController(text: '0');
  TextEditingController rtpTimestampGapController =
      TextEditingController(text: '20');
  TextEditingController rtpSendIntervalController =
      TextEditingController(text: '160');
  TextEditingController rtpBundleController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scenarioFilePathController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Scenario File is not selected')),
            );
            return;
          } else if (targetAddrController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Target Address input')),
            );
            return;
          }
          print('tttt');
        },
        child: const Icon(Icons.arrow_forward_ios),
        elevation: 8,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                const Text(
                  'UTGen Runner',
                ),
                const Divider(color: Colors.transparent),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: scenarioFilePathController,
                        obscureText: false,
                        focusNode: FocusNode(),
                        enabled: false,
                        enableInteractiveSelection: false,
                        decoration: const InputDecoration(
                          labelText: "Scenario File Path\n",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return 'Input Scenario File path';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            PlatformFile file = result.files.first;
                            scenarioFilePathController.text = file.path!;
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: const Text('Search File'),
                      ),
                    )
                  ],
                ),
                const Divider(color: Colors.transparent),
                defaultTextFieldForm(
                    labelText: 'SIP Target Address',
                    controller: targetAddrController),
                const Divider(color: Colors.transparent),
              ]),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'SIP Config',
                  ),
                  TextFormField(
                    controller: sipIpController,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input IP';
                      }
                      if (!ipExp.hasMatch(value)) {
                        return 'Wrong IP';
                      }
                      return '??';
                    },
                    onChanged: (value) {
                      if (value == null || value.isEmpty) {
                        print("TTTT1");
                        return;
                      }
                      if (!ipExp.hasMatch(value)) {
                        print("TTTT2");
                        return;
                      }
                      print("TTTT3");
                    },
                    decoration: const InputDecoration(
                      labelText: "SIP IP1",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'SIP IP', controller: sipIpController),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'SIP Port',
                      controller: sipPortController,
                      keyboardType: TextInputType.number),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'RTP Config',
                  ),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                    labelText: 'Media IP',
                    controller: mediaIpController,
                  ),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'Media Port',
                      controller: mediaPortController,
                      keyboardType: TextInputType.number),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'Minimum RTP Port',
                      controller: minRtpPortController,
                      keyboardType: TextInputType.number),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'Maximum RTP Port',
                      controller: maxRtpPortController,
                      keyboardType: TextInputType.number),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'RTP Send Interval',
                      controller: rtpSendIntervalController,
                      keyboardType: TextInputType.number),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'RTP Timestamp Gap',
                      controller: rtpTimestampGapController,
                      keyboardType: TextInputType.number),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                      labelText: 'RTP Bundle',
                      controller: rtpBundleController,
                      keyboardType: TextInputType.number),
                  const Divider(color: Colors.transparent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateIp(String? value) {
    if (!ipExp.hasMatch(value!)) {
      return value;
    }
    return null;
  }

  String? _validatePort(String? value) {
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value!)) {
      return value;
    }
    return null;
  }

  TextFormField defaultTextFieldForm({
    String labelText = '',
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: "$labelText\n",
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
