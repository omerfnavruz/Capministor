// Copyright 2022 CapLox Team. All rights reserved.
import 'package:capministortry/views/main_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final List<GlobalObjectKey<FormState>> formKeyList = List.generate(10, (index) => GlobalObjectKey<FormState>(index));
FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final mailController = TextEditingController();
final passwordController = TextEditingController();
final database = FirebaseDatabase.instance.ref();
bool signSuccess = false;
showAlertDialog(BuildContext context, String message) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {  Navigator.of(context).pop();
      },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
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

Future<void> signIn(String mail, String passW, BuildContext context)
async {
  signSuccess = true;
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: passW
    );
  } on FirebaseAuthException catch (e) {
    signSuccess = false;
    if (e.code == 'user-not-found') {
      showAlertDialog(context,"User not found");
    } else if (e.code == 'wrong-password') {
      showAlertDialog(context,"Wrong password provided for that user.");
    }
  }
}

Future<void> signUp(String mail, String passW, BuildContext context)
async {
  signSuccess = true;
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: passW
    );
  } on FirebaseAuthException catch (e) {
    signSuccess = false;
    if (e.code == 'weak-password') {
      showAlertDialog(context, "Password is too weak, please enter a stronger password.");
    }
    else if (e.code == 'email-already-in-use') {
      showAlertDialog(context,"The account already exists for that email.");
    }
  } catch (e) {
    showAlertDialog(context, e.toString());
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  print("Hello");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

@override

Widget build(BuildContext context) {

return const MaterialApp(
    title: 'Capministor',
    home: MyHomePage(title: 'Log in or Sign up',),
);
}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Builder(builder: (BuildContext context) {
          return Center(
              child: Column(
                children: [
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    key: formKeyList[1],
                    controller: mailController,
                    decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Your E-mail',
                  ),
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      obscureText: true,
                      key: formKeyList[2],
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter Your Password',
                      ),
                    ),
                  ),

              ElevatedButton(
                onPressed: () async {
                  await signIn(mailController.text, passwordController.text, context);
                  final fcmToken = await FirebaseMessaging.instance.getToken();

                  if(signSuccess){
                    database.child('FCM').update(
                        {
                          mailController.text.substring(0, mailController.text.indexOf('@')): fcmToken
                        }
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                    );
                  }
                },
                child: const Text('Sign In'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await signUp(mailController.text, passwordController.text, context);
                  if(signSuccess){
                    final fcmToken = await FirebaseMessaging.instance.getToken();
                    database.child('FCM').update(
                      {
                        mailController.text.substring(0, mailController.text.indexOf('@')): fcmToken
                      }
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                    );
                  }
                },
                child: const Text('Sign Up'),
              ),
              InkWell(

              ),
            ],
              )
          );


      }),
    );
  }
}

