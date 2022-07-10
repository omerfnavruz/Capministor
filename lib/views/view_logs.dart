//import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final _database = FirebaseDatabase.instance.ref();
var list;
final tilesList  = <ListTile>[];




class ViewLog extends StatefulWidget
{

  const ViewLog({Key? key}) : super(key: key);
  @override
  State<ViewLog> createState() => _ViewLogState();
}

class _ViewLogState extends State<ViewLog> {
  int _selectedIndex = -1;
  final _storage = firebase_storage.FirebaseStorage.instance.ref().child('Residents');
  //var list;
  var counter = 0;

  @override
  void initState() {
    super.initState();
    list = FirebaseList(
        query: _database.child('Logging').orderByValue().limitToLast(200),
        onChildAdded: (pos, snapshot) {},
        onChildRemoved: (pos, snapshot) {},
        onChildChanged: (pos, snapshot) {},
        onChildMoved: (oldPos, newPos, snapshot) {},
        onValue: (snapshot) async {
          tilesList.clear();
          for (var i=0; i < list.length; i++) {
            //print('$i: ${list[i].value}');
            final nextResident = list[i].value;
            final residentTile = ListTile(
              title: Text(nextResident!['name'] + " " + nextResident!['type']),
              subtitle: Text(nextResident['time']),
            );
            tilesList.add(residentTile);
          }
        }
    );
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Log Records'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Builder(
                  builder: (context)
                  {
                    if(tilesList.isNotEmpty){
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: ()async{
                            setState(() {

                            });
                          },
                          child: ListView.builder(
                            itemCount: tilesList.length,
                            itemBuilder: (BuildContext context, int index)
                            {
                              return ListTile(
                                leading: tilesList[index].leading,
                                title: tilesList[index].title,
                                subtitle: tilesList[index].subtitle,
                                selected: index==_selectedIndex,
                                onLongPress: (){
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },

                              );
                            },

                          )
                      ));
                    }
                    else
                    {
                      return Expanded(
                          child: RefreshIndicator(
                            child: const Text("No data in the database"),
                            onRefresh: () async{
                              setState(() {

                              });
                            },
                          ),
                    );
                    }

                  })
            ],
          ),
        ),
      ),
    );
  }
}
