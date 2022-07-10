//import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ViewGuests extends StatefulWidget
{

  const ViewGuests({Key? key}) : super(key: key);

  @override
  State<ViewGuests> createState() => _ViewGuestsState();
}

class _ViewGuestsState extends State<ViewGuests> {
  final _database = FirebaseDatabase.instance.ref();
  int _selectedIndex = -1;
  final _storage = firebase_storage.FirebaseStorage.instance.ref().child('Guests');

  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Guests'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: _database.child('Guests').orderByValue().limitToLast(10).onValue,
                  builder: (context, AsyncSnapshot snapshot)
                  {
                    final tilesList = <ListTile>[];
                    if(snapshot.hasData && (snapshot.data!).snapshot.value!=null)
                    {
                      final Map<String?, dynamic> myGuests = Map<String?, dynamic>.from((snapshot.data!).snapshot.value);
                      counter = 0;
                      myGuests.forEach((key, value) async {
                        final nextguest = value;
                        final isHome = nextguest['isHome'] == 1;
                        final loc = isHome? "Home": "Outside";

                        final guestTile = ListTile(
                          leading: Image.network(
                            nextguest['Image URL'],
                            height: 50,
                            width: 50,
                          ),
                          title: Text(nextguest['Name']),
                          subtitle: Text("Location : " + loc),
                        );
                        tilesList.add(guestTile);
                        counter++;
                      });
                      return Expanded(
                          child: ListView.builder(
                            itemCount: counter,
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
                                trailing: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _storage.child((tilesList[index].title as Text).data!).delete();
                                      _database.child('Guests').child((tilesList[index].title as Text).data!).remove();
                                      //print((tilesList[index].title as Text).data.toString());
                                      counter = counter-1;
                                    });
                                  },
                                  icon: const Icon(Icons.remove),
                                ),

                              );
                            },

                          )
                      );
                    }
                    else
                    {
                      return const Expanded(child: Text("No data in the database"));
                    }

                  })
            ],
          ),
        ),
      ),
    );
  }
}
