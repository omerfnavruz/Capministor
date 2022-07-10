import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';


class ManageDatabase extends StatefulWidget
{
  const ManageDatabase({Key? key}) : super(key: key);

  @override
  _ManageDatabaseState createState() => _ManageDatabaseState();
}

class _ManageDatabaseState extends State<ManageDatabase>
{
  final database = FirebaseDatabase.instance.ref();
  final storage = firebase_storage.FirebaseStorage.instance.ref().child('Residents');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final nameController2 = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool value = false;
  bool value2 = false;
  @override
  Widget build(BuildContext context) {
    final residents = database.child('Residents/');
    final guests = database.child('Guests/');
    final flags = database.child('Flags');
    File _imageFile;
    dynamic image;

   return Scaffold(
     appBar: AppBar(title: const Text('Manage Database'),),
     body: Center(
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
             child: TextFormField(
               key: _formKey,
               controller: nameController,
               decoration: const InputDecoration(
                 border: UnderlineInputBorder(),
                 labelText: 'Enter Resident/Guest Name',
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
             child: TextFormField(
               key: _formKey2,
               controller: nameController2,
               decoration: const InputDecoration(
                 border: UnderlineInputBorder(),
                 labelText: 'Enter e-mail for notification, leave empty for guests.',
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Check this box for guests"),
                Checkbox(value: this.value2,
                    onChanged: (bool? value2){
                      setState(() {
                        this.value2 = value2!;
                      });}
                )
              ],
            ),
           ),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Text("Check if the person is home right now."),
                 Checkbox(value: this.value,
                     onChanged: (bool? value){
                       setState(() {
                         this.value = value!;
                       });}
                 )
               ],
             ),
           ),

           ElevatedButton(
             onPressed: () async {
               image = await _picker.pickImage(source: ImageSource.gallery);

             },
             child: const Text('Select Picture'),
           ),

           ElevatedButton(
             onPressed: () async {
                 final isHome = value ? 1:0;
                 _imageFile = File(image.path);
                 final snapshot = await storage.child(nameController.text).putFile(_imageFile);
                 String downloadURL = await snapshot.ref.getDownloadURL();
                 if(value2) {
                   guests.child(nameController.text).update({
                     'Name':nameController.text,
                     'isHome':isHome,
                     'Image URL': downloadURL
                   });
                 }
                 else {
                   residents.child(nameController.text).update({
                     'Name': nameController.text,
                     'email': nameController2.text,
                     'isHome': isHome,
                     'Image URL': downloadURL,
                     'stdLogin':   479,
                     'stdLogout':  479,
                     'sizeLogin':  2,
                     'sizeLogout': 2,
                     'meanLogin' : 0,
                     'meanLogout': 0,
                   });
                 }
                 flags.update({'Updated':"True"});

             },
             child: const Text('Submit'),
           ),
         ],
       ),
     )
   );
  }
  
  
}