import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:utgen/run_page.dart';

class Utgen extends StatelessWidget {
  const Utgen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  String? javaFile = '/Users/heokangmoo/temp/utgen-jar-with-dependencies.jar';
  String? scenarioFile;
  String? targetSipIp;
  String? targetSipPort;

  // SIP Options
  String? sipIp;
  String? sipPort;

  // RTP Options
  String? mediaIp;
  String? mediaPort;
  String? minRtpPort;
  String? maxRtpPort;
  String? rtpSendInterval;
  String? rtpTimestampGap;
  String? rtpBundle;

  // Call Rate Options
  String? rate; // -r
  String? ratePeriod; // -rp
  String? limit; // -l
  String? maxCall; // -m

  TextEditingController scenarioFilePathController =
      TextEditingController(text: 'abcd');
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
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Running UTGen...')),
            );
            String command =
                'java -jar $javaFile -sf $scenarioFile $targetSipIp:$targetSipPort $sipIp $sipPort $mediaIp $mediaPort $minRtpPort $maxRtpPort $rtpTimestampGap $rtpSendInterval $rtpBundle $rate $ratePeriod $limit $maxCall';
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RunPage(key: Key("CupertinoPage"), command: command)));
          }
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
                    initalValue: '127.0.0.1',
                    validator: _validateIp,
                    isMandatory: true,
                    onSaved: (val) {
                      targetSipIp = val;
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Target Port',
                    initalValue: '1234',
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
                    validator: _validateIp,
                    onSaved: (val) {
                      sipIp = '-i $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'SIP Port',
                    keyboardType: TextInputType.number,
                    initalValue: '5060',
                    validator: _validatePort,
                    onSaved: (val) {
                      sipPort = '-p $val';
                    },
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 50,
                  ),
                  const Text(
                    'RTP Config',
                  ),
                  defaultTextFieldForm(
                      label: 'Media IP',
                      controller: mediaIPController,
                      validator: _validateIp,
                      onSaved: (val) {
                        mediaIp = '-mi $val';
                      }),
                  defaultTextFieldForm(
                    label: 'Media Port',
                    keyboardType: TextInputType.number,
                    initalValue: '0',
                    validator: _validatePort,
                    onSaved: (val) {
                      mediaPort = '-mp $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Minimum RTP Port',
                    keyboardType: TextInputType.number,
                    initalValue: '0',
                    validator: _validatePort,
                    onSaved: (val) {
                      minRtpPort = '-min_rtp_port $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Maximum RTP Port',
                    keyboardType: TextInputType.number,
                    initalValue: '0',
                    validator: _validatePort,
                    onSaved: (val) {
                      maxRtpPort = '-max_rtp_port $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'RTP Send Interval',
                    keyboardType: TextInputType.number,
                    initalValue: '20',
                    validator: _validateNumber,
                    onSaved: (val) {
                      rtpSendInterval = '-media_send_gap $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'RTP Timestamp Gap',
                    keyboardType: TextInputType.number,
                    initalValue: '160',
                    validator: _validateNumber,
                    onSaved: (val) {
                      rtpTimestampGap = '-media_timestamp_gap $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'RTP Bundle',
                    keyboardType: TextInputType.number,
                    initalValue: '1',
                    validator: _validateNumber,
                    onSaved: (val) {
                      rtpBundle = '-rtp_bundle $val';
                    },
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 50,
                  ),
                  const Text(
                    'Call Config',
                  ),
                  defaultTextFieldForm(
                    label: 'Rate',
                    keyboardType: TextInputType.number,
                    initalValue: '10',
                    validator: _validateNumber,
                    onSaved: (val) {
                      rate = '-r $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Rate Period',
                    keyboardType: TextInputType.number,
                    initalValue: '1000',
                    validator: _validateNumber,
                    onSaved: (val) {
                      ratePeriod = '-rp $val';
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Limit',
                    keyboardType: TextInputType.number,
                    initalValue: '-1',
                    validator: _validateNumber,
                    onSaved: (val) {
                      if (int.parse(val) <= 0) {
                        limit = '';
                      } else {
                        limit = '-l $val';
                      }
                    },
                  ),
                  defaultTextFieldForm(
                    label: 'Max Call',
                    keyboardType: TextInputType.number,
                    initalValue: '0',
                    validator: _validateNumber,
                    onSaved: (val) {
                      maxCall = '-m $val';
                    },
                  ),
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
        if (0 <= port && port <= 65535) {
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
        onSaved: onSaved,
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
}

Future<String> getIp() async {
  return (await NetworkInterface.list())[0].addresses[0].address;
}
