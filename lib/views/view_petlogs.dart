import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
final _database = FirebaseDatabase.instance.ref();
var list;
final tilesList  = <ListTile>[];




class ViewPetLog extends StatefulWidget
{

  const ViewPetLog({Key? key}) : super(key: key);
  @override
  State<ViewPetLog> createState() => _ViewPetLogState();
}

class _ViewPetLogState extends State<ViewPetLog> {
  int _selectedIndex = -1;
  var counter = 0;

  @override
  void initState() {
    super.initState();
    list = FirebaseList(
        query: _database.child('PetLog').orderByValue().limitToLast(200),
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
        title: const Text('View Log Records Of Your Pets'),
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
