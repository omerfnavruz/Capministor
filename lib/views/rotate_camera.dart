import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class SetCameraAngle extends StatefulWidget
{
  const SetCameraAngle({Key? key}) : super(key: key);

  @override
  _SetCameraAngleState createState() => _SetCameraAngleState();
}

class _SetCameraAngleState extends State<SetCameraAngle>
{
  final database = FirebaseDatabase.instance.ref();
  var storage = FirebaseStorage.instance.ref().child('frame');
  var url = "https://media.istockphoto.com/vectors/loading-icon-vector-illustration-vector-id1335247217?k=20&m=1335247217&s=612x612&w=0&h=CQFY4NO0j2qc6kf4rTc0wTKYWL-9w5ldu-wF8D4oUBk=";
  @override
  Widget build(BuildContext context) {
    final flags = database.child('Flags');
    int angle = 0;


    return Scaffold(
        appBar: AppBar(title: const Text('Set Camera Angle'),),
        body: Center(
          child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0,50,0,50),
                  width: 360,
                  height: 370,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      storage = FirebaseStorage.instance.ref().child('frame.png');
                      url = await storage.getDownloadURL();
                      setState(() {

                      });
                    },
                    child: const Text ("Refresh View")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      IconButton(
                        iconSize: 100,
                        onPressed: () async {
                          angle = angle - 5;
                          flags.update({'Angle': 5, 'photoTaken': '1'});

                        },
                        icon: const Icon(Icons.arrow_left),
                      ),

                      IconButton(
                        iconSize: 100,
                        onPressed: () async {
                          angle = angle + 5;
                          flags.update({'Angle': -5, 'photoTaken': '1'});
                        },
                        icon: const Icon(Icons.arrow_right),
                      ),
                  ],
              ), ]
          ),
          ),

    );
  }


}