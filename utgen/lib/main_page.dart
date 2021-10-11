import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
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
  TextEditingController scenarioFilePathController = TextEditingController();

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
          test();
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Running UTGen...')),
            );
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
                      isMandatory: true),
                  defaultTextFieldForm(
                      label: 'Target Port',
                      keyboardType: TextInputType.number,
                      isMandatory: true,
                      validator: _validatePort),
                  const Text(
                    'SIP Config',
                  ),
                  defaultTextFieldForm(label: 'SIP IP'),
                  defaultTextFieldForm(
                      label: 'SIP Port', keyboardType: TextInputType.number),
                  const Text(
                    'RTP Config',
                  ),
                  defaultTextFieldForm(
                    label: 'Media IP',
                  ),
                  defaultTextFieldForm(
                      label: 'Media Port',
                      keyboardType: TextInputType.number,
                      initalValue: '0'),
                  defaultTextFieldForm(
                      label: 'Minimum RTP Port',
                      keyboardType: TextInputType.number,
                      initalValue: '0'),
                  defaultTextFieldForm(
                      label: 'Maximum RTP Port',
                      keyboardType: TextInputType.number,
                      initalValue: '0'),
                  defaultTextFieldForm(
                      label: 'RTP Send Interval',
                      keyboardType: TextInputType.number,
                      initalValue: '20'),
                  defaultTextFieldForm(
                      label: 'RTP Timestamp Gap',
                      keyboardType: TextInputType.number,
                      initalValue: '160',
                      validator: (val) {}),
                  defaultTextFieldForm(
                      label: 'RTP Bundle',
                      keyboardType: TextInputType.number,
                      initalValue: '1'),
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
      List<TextInputFormatter>? inputFormatters}) {
    return Column(children: [
      const Divider(
        color: Colors.transparent,
      ),
      TextFormField(
        initialValue: initalValue,
        keyboardType: keyboardType,
        validator: validator,
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
    print('TTTT');
    var shell = Shell();
    print('TTTT2');
    await shell.run('''
    echo Hello

# Display some text
echo Hello

# Display dart version
dart --version

# Display pub version
pub --version

  ''');
    print('TTTT3');
    shell = shell.pushd('example');
    print('TTTT4');
    await shell.run('''

# Listing directory in the example folder
dir

  ''');
    print('TTTT5');
    shell = shell.popd();
    print('TTTT6');
  }
}
