import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final _database = FirebaseDatabase.instance.ref();
final _flags = _database.child('Flags');
final _logs = _database.child('Logging');
final _petlogs = _database.child('PetLog');
showRestartDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      _flags.update({'Updated':"True"});
      _flags.update({'Pause': 0});
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Would you like to restart the system?"),
    content: const Text("Your security system will be restarted"),
    actions: [
      okButton,
      cancelButton,
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

showClearDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      _logs.remove();
      _petlogs.remove();
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Would you like to clear the log records?"),
    content: const Text("All log records will be deleted from your database"),
    actions: [
      okButton,
      cancelButton,
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

showPauseDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      _flags.update({'Pause': 1});
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Would you like to disable your security system?"),
    content: const Text("You can re-enable your system by hitting restart system"),
    actions: [
      okButton,
      cancelButton,
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

showAnomalyDialog(BuildContext context, bool enableAnomaly) {

  // set up the button
  Widget toggleButton = TextButton(
    child: const Text("Yes"),
    onPressed: () async {
      _flags.update({'enableAnomaly': enableAnomaly ? 1:0});
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(enableAnomaly ? "Enable anomaly detections ": "Disable anomaly detections"),
    content: Text(enableAnomaly ? "Would you like to re-enable anomaly detections?": "Are you sure you would like to disable anomaly detections?"),
    actions: [
      toggleButton,
      cancelButton,
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


class SystemConfig extends StatelessWidget
{
  const SystemConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("System Configuration"),
      ),
      body: Center(
        child: ListView(
            prototypeItem: const Divider(
              height: 80,
              thickness: 500,
              color: Colors.red,
              indent: 20,
              endIndent: 20,
            ),
            children: [
            InkWell(
              onTap: () {
                showRestartDialog(context);
             },
              child:Container(
                padding: const EdgeInsets.fromLTRB(32,32,32,0),
                child: Row(
                  children: [
                    Expanded(
                      /*1*/
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*2*/
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              'Restart System',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            'Restart all systems including detection and recognition.',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*3*/
                    Icon(
                      Icons.restart_alt,
                      color: Colors.blue[500],
                      size: 35,
                    ),

                  ],
                ),
          )),
              InkWell(
                  onTap: () {
                    showClearDialog(context);
                  },
                  child:Container(
                    padding: const EdgeInsets.fromLTRB(32,32,32,0),
                    child: Row(
                      children: [
                        Expanded(
                          /*1*/
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                  'Clear Logs',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Text(
                                'Delete all the log records of entries and exits.',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*3*/
                        Icon(
                          Icons.delete_forever,
                          color: Colors.blue[500],
                          size: 35,
                        ),

                      ],
                    ),
                  )),
              InkWell(
                  onTap: () {
                    showPauseDialog(context);
                  },
                  child:Container(
                    padding: const EdgeInsets.fromLTRB(32,32,32,0),
                    child: Row(
                      children: [
                        Expanded(
                          /*1*/
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                  'Stop the System',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Text(
                                'Disable the whole security system',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*3*/
                        Icon(
                          Icons.stop,
                          color: Colors.red[500],
                          size: 35,
                        ),

                      ],
                    ),
                  )),
        InkWell(
            onTap: () async{
              final event = await _flags.child('enableAnomaly').once();
              var enableAnomaly = event.snapshot.value! == 0;
              showAnomalyDialog(context, enableAnomaly);
            },
            child:Container(
              padding: const EdgeInsets.fromLTRB(32,32,32,0),
              child: Row(
                children: [
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*2*/
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Enable or Disable Anomaly Detections',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Toggle your Anomaly Preference',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*3*/
                  Icon(
                    Icons.toggle_off_outlined,
                    color: Colors.blue[500],
                    size: 35,
                  ),

                ],
              ),
            )),

            ]
        )
      ),
    );
  }
}