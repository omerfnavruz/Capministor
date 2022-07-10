//import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final _database = FirebaseDatabase.instance.ref();
var list1, list2;
final tilesList1  = <ListTile>[];
final tilesList2  = <ListTile>[];
var tilesList  = <ListTile>[];




class PeopleHome extends StatefulWidget
{

  const PeopleHome({Key? key}) : super(key: key);
  @override
  State<PeopleHome> createState() => _PeopleHomeState();
}

class _PeopleHomeState extends State<PeopleHome> {
  int _selectedIndex = -1;
  //var list;

  @override
  void initState() {
    super.initState();
    list1 = FirebaseList(
        query: _database.child('Residents').orderByValue().limitToLast(10),
        onChildAdded: (pos, snapshot) {},
        onChildRemoved: (pos, snapshot) {},
        onChildChanged: (pos, snapshot) {},
        onChildMoved: (oldPos, newPos, snapshot) {},
        onValue: (snapshot) async {
          tilesList1.clear();
          for (var i=0; i < list1.length; i++) {
            //print('$i: ${list1[i].value}');
            final nextResident = list1[i].value;

            if(nextResident!['isHome'] == 1)
            {
              final residentTile = ListTile(
                leading: Image.network(
                  nextResident['Image URL'],
                  height: 50,
                  width: 50,
                ),
                title: Text(nextResident['Name']),
                subtitle: const Text('Resident'),
              );
              tilesList1.add(residentTile);
            }
          }
        }
    );
    list2 = FirebaseList(
        query: _database.child('Guests').orderByValue().limitToLast(10),
        onChildAdded: (pos, snapshot) {},
        onChildRemoved: (pos, snapshot) {},
        onChildChanged: (pos, snapshot) {},
        onChildMoved: (oldPos, newPos, snapshot) {},
        onValue: (snapshot) async {
          tilesList2.clear();
          for (var i=0; i < list2.length; i++) {
            //print('$i: ${list2[i].value} here');

            final nextGuest = list2[i].value;
            if(nextGuest!['isHome'] == 1)
            {
              final guestTile = ListTile(
                leading: Image.network(
                  nextGuest['Image URL'],
                  height: 50,
                  width: 50,
                ),
                title: Text(nextGuest['Name']),
                subtitle: const Text('Guest'),
              );
              tilesList2.add(guestTile);
            }
          }
        }
    );
    tilesList = tilesList1 + tilesList2;
    final totalTile = ListTile(
      title: Text('Total number: ' + tilesList.length.toString()),
    );
    tilesList.add(totalTile);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who is at Home?'),
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
                          child: const Text("No one is at home"),
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
