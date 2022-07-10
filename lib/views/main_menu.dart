// Copyright 2022 CapLox Team. All rights reserved.
import 'package:capministortry/views/manage_database.dart';
import 'package:capministortry/views/people_home.dart';
import 'package:capministortry/views/view_database.dart';
import 'package:capministortry/views/rotate_camera.dart';
import 'package:capministortry/views/view_guests.dart';
import 'package:capministortry/views/view_logs.dart';
import 'package:capministortry/views/view_petlogs.dart';
import 'package:capministortry/views/system_config.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';


class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return  const MainList();

  }
}

class MainList extends StatelessWidget
{
  const MainList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    Widget item1 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ManageDatabase()),
          );
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
                        'Manage Database',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'Add or Remove Residents',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.person_add,
                color: Colors.blue[500],
                size:35,
              ),
              Icon(
                Icons.person_remove,
                color: Colors.red[500],
                size:35,
              ),
            ],
          ),
        ));
    Widget item2 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewDatabase()),
          );
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
                        'View Database',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'See your database up-to-date',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.view_list_outlined,
                color: Colors.blue[500],
                size: 40,
              ),
            ],
          ),
        ));
    Widget item2_3 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PeopleHome()),
          );
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
                        'Who is at Home?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'View who are currently at home.',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.home_filled,
                color: Colors.blue[500],
                size: 40,
              ),
            ],
          ),
        ));
    Widget item2_2 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewGuests()),
          );
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
                        'View Guests',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'See your database up-to-date',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.view_list_outlined,
                color: Colors.blue[500],
                size: 40,
              ),
            ],
          ),
        ));

    Widget item3 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SetCameraAngle()),
          );
        },
        child: Container(

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
                        'Set Camera Angle',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'Change Field of View of the Camera',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.video_camera_back,
                color: Colors.blue[500],
                size:35,
              ),
              Icon(
                  Icons.settings_backup_restore_sharp,
                  color: Colors.red[500],
                  size:35
              ),
            ],
          ),
        ));

    Widget item4 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewLog()),
          );
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
                        'View Logs',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'View the log records of entries and exits.',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.event_note,
                color: Colors.blue[500],
                size: 35,
              ),

            ],
          ),
        ));

    Widget item5 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewPetLog()),
          );
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
                        'View Pet Logs',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'View the log records of your pets.',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.event_note,
                color: Colors.blue[500],
                size: 35,
              ),

            ],
          ),
        ));

    Widget item6 = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SystemConfig()),
          );
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
                        'System Configuration',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      'Turn System On/Off, Manage Settings, etc.',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.settings,
                color: Colors.blue[500],
                size:37,
              ),

            ],
          ),
        ));

    Widget mainListBody = ListView(
      prototypeItem: const Divider(
        height: 80,
        thickness: 500,
        color: Colors.red,
        indent: 20,
        endIndent: 20,
      ),
      children: [item1, item2, item2_2, item2_3, item3, item4, item5, item6],

    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Capministor'),
      ),
      body: mainListBody,
    );
  }
}



