import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:process_run/shell.dart';

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
  final ipExp = RegExp(r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$",
      caseSensitive: false, multiLine: false);
  final numExp = RegExp(r'[0-9]');

  String? javaFile;
  String? scenarioFile;
  String? targetSipIp;
  String? targetSipPort;
  String? sipIp;
  String? sipPort;
  String? mediaIp;
  String? mediaPort;
  String? minRtpPort;
  String? maxRtpPort;
  String? rtpSendInterval;
  String? rtpTimestampGap;
  String? rtpBundle;

  TextEditingController scenarioFilePathController = TextEditingController();
  TextEditingController sipIPController = TextEditingController();
  TextEditingController mediaIPController = TextEditingController();
  TextEditingController testController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getIp()
        .then((value) => mediaIPController.text = sipIPController.text = value);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          test();
          // if (formKey.currentState!.validate()) {
          //   formKey.currentState!.save();
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text('Running UTGen...')),
          //   );
          //   print(
          //       'java -jar -sf $scenarioFile $targetSipIp:$targetSipPort -i $sipIp -p $sipPort -mi $mediaIp -mp $mediaPort -min_rtp_port $minRtpPort -max_rtp_port $maxRtpPort -media_timestamp-gap $rtpTimestampGap -media_send_gap $rtpSendInterval -rtp_bundle $rtpBundle');
          // }
        },
        child: const Icon(Icons.arrow_forward_ios),
        elevation: 8,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: this.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(mainAxisSize: MainAxisSize.max, children: [
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
                          onSaved: (val) {
                            scenarioFile = val;
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Scenario File is not selected';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.star),
                            labelText: "Scenario File Path\n",
                            errorStyle: TextStyle(
                              color: Theme.of(context)
                                  .errorColor, // or any other color
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();
                              if (result != null) {
                                PlatformFile file = result.files.first;
                                scenarioFilePathController.text = file.path!;
                              } else {
                                // User canceled the picker
                              }
                            } catch (e) {
                              showAlertDialog(
                                  context, 'Error', 'Fail to load file\n$e');
                            }
                          },
                          child: const Text('Load'),
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  defaultTextFieldForm(
                    label: 'Target IP',
                    validator: _validateIp,
                    isMandatory: true,
                    onSaved: (val) {
                      targetSipIp = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Target Port',
                    keyboardType: TextInputType.number,
                    isMandatory: true,
                    validator: _validatePort,
                    onSaved: (val) {
                      targetSipPort = val;
                    },
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 50,
                  ),
                  const Text(
                    'SIP Config',
                  ),
                  defaultTextFieldForm(
                    label: 'SIP IP',
                    initalValue: sipIp,
                    controller: sipIPController,
                    onSaved: (val) {
                      sipIp = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'SIP Port',
                    keyboardType: TextInputType.number,
                    initalValue: '5060',
                    onSaved: (val) {
                      sipPort = val;
                    },
                  ),
                  const Text(
                    'RTP Config',
                  ),
                  defaultTextFieldForm(
                    label: 'Media IP',
                    controller: mediaIPController,
                  ),
                  defaultTextFieldForm(
                    label: 'Media Port',
                    keyboardType: TextInputType.number,
                    initalValue: '0',
                    onSaved: (val) {
                      mediaPort = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Minimum RTP Port',
                    keyboardType: TextInputType.number,
                    initalValue: '0',
                    onSaved: (val) {
                      minRtpPort = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Maximum RTP Port',
                    keyboardType: TextInputType.number,
                    initalValue: '0',
                    onSaved: (val) {
                      maxRtpPort = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'RTP Send Interval',
                    keyboardType: TextInputType.number,
                    initalValue: '20',
                    onSaved: (val) {
                      rtpSendInterval = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'RTP Timestamp Gap',
                    keyboardType: TextInputType.number,
                    initalValue: '160',
                    validator: (val) {
                      rtpTimestampGap = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'RTP Bundle',
                    keyboardType: TextInputType.number,
                    initalValue: '1',
                    onSaved: (val) {
                      rtpBundle = val;
                    },
                  ),
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: Text(sb.toString()),
                  //   ),
                  // ),
                  TextField(
                    controller: testController,
                    maxLines: 30,
                    // readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Output',
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateIp(String? value) {
    if (!ipExp.hasMatch(value!)) {
      return 'Wrong IP';
    }
    return null;
  }

  String? _validatePort(String? value) {
    try {
      if (!numExp.hasMatch(value!)) {
        return 'Wrong Port';
      } else {
        var port = int.parse(value);
        if (1024 < port && port <= 65535) {
          return null;
        } else {
          return 'Wrong Param';
        }
      }
    } catch (e) {
      return 'Wrong Port';
    }
  }

  String? _validateNumber(String? value) {
    if (!numExp.hasMatch(value!)) {
      return 'Wrong Port';
    }
    return null;
  }

  defaultTextFieldForm(
      {required String label,
      String? initalValue,
      FormFieldSetter? onSaved,
      FormFieldValidator<String>? validator,
      TextInputType? keyboardType,
      bool isMandatory = false,
      List<TextInputFormatter>? inputFormatters,
      TextEditingController? controller}) {
    return Column(children: [
      const Divider(
        color: Colors.transparent,
      ),
      TextFormField(
        initialValue: initalValue,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        inputFormatters:
            inputFormatters == null && keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.allow(numExp)]
                : inputFormatters,
        decoration: InputDecoration(
          icon: isMandatory ? Icon(Icons.star) : Icon(null),
          labelText: "$label\n",
        ),
      ),
      const Divider(
        color: Colors.transparent,
      ),
    ]);
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

  Future test() async {
    // This works on Windows/Linux/Mac
    var controller = ShellLinesController();
    var shell = Shell(stdout: controller.sink, verbose: false);
    controller.stream.listen((event) {
      this.testController.text += '\n' + event;
      // Handle output

      // ...
      // If needed kill the shell
      shell.kill();
    });
    try {
      await shell.run('echo Hello');
    } on ShellException catch (_) {
      // We might get a shell exception
    }

//     var shell = Shell();
//     await shell.run('''
//     echo Hello

// # Display some text
// echo Hello

// # Display dart version
// dart --version

// # Display pub version
// pub --version

//   ''');
//     shell = shell.pushd('example');
//     await shell.run('''

// # Listing directory in the example folder
// dir

//   ''');
//     shell = shell.popd();
  }
}

Future<String> getIp() async {
  return (await NetworkInterface.list())[0].addresses[0].address;
}
