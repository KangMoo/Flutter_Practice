import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

class RunPage extends StatefulWidget {
  const RunPage({Key? key, required this.command}) : super(key: key);
  final String command;
  @override
  _RunPageState createState() => _RunPageState();
}

class _RunPageState extends State<RunPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController logController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    runCommand(widget.command);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('UTGen'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.navigate_next),
        //     tooltip: 'UTGen',
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: TextField(
            //readOnly: true,
            controller: logController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Future runCommand(String command) async {
    print("RUN [$command]");
    // This works on Windows/Linux/Mac
    try {
      var controller = ShellLinesController();
      var shell = Shell(
          stdout: controller.sink, stderr: controller.sink, verbose: false);
      controller.stream.listen((event) {
        logController.text += '\n' + event;

        shell.kill();
      });
      await shell.run(command);
    } catch (e) {
      showAlertDialog(context, 'Runtime Error', e.toString());
    }
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
  }
}
