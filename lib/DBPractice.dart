import 'package:flutter/material.dart';
import 'package:untitled/Apidata/DB/DBInserformmodal.dart';
import 'package:untitled/Apidata/jsonlive/Localmodaldashboard.dart';

import 'package:untitled/NotesModel.dart';
import 'package:untitled/SqfliteDatabaseHelper.dart';
import 'package:untitled/SyncronizationData.dart';

import 'Apidata/Getdatamodal.dart';
import 'Apidata/Inserform.dart';

class DBPractice extends StatefulWidget {
  const DBPractice({super.key});

  @override
  State<DBPractice> createState() => _DBPracticeState();
}

class _DBPracticeState extends State<DBPractice> {
  SqfliteDatabaseHelper? dbHelper;
  late Future<List<NotesModel>> noteslist;
  late Future<List<DbInserformmodal>> getlistofinservalues;

  late Getdatamodal? getdatamodalres;

  SqfliteDatabaseHelper? sqfliteDatabaseHelper;
  List<Result> mainlist = [];
  List<DbInserformmodal> contactlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqfliteDatabaseHelper = SqfliteDatabaseHelper();

    dbHelper = SqfliteDatabaseHelper();
    getdatamodalres =
        Getdatamodal(status: true, message: "success", result: []);

    loaddata();
    //isInternet();
    setState(() {
      setState(() {
        getlistofinservalues = sqfliteDatabaseHelper!.getinserformvalueslist();
      });
    });
  }

/*Future synchtomysql() async{
await SyncronizationData().getnoteslist().then((value) {
  print("ooo"+value.length.toString());

});

await SyncronizationData().getinserformvalueslist().then((value) {
  print("lengthof_insertform"+value.length.toString());

});
await SyncronizationData().fatchallcustumerinfo().then((getlistofinservalues) async {
//  inserdataApi
  print("running");
  await SyncronizationData(). savetomysqlinserdataApi(getlistofinservalues).then((value) {
    print("lengthof_contactlist"+getlistofinservalues.toString());

  });
  print("finished");
  print(contactlist);
  print("lengthof_originaldata"+getlistofinservalues.toString());

});
}*/

/*  Future isInternet() async{
    await SyncronizationData.isInternet().then((connection) {
      if(connection){
        print("connectionchek" +connection.toString());

        //synchtomysql();
        if(connection==false) {
           SyncronizationData().fatchallcustumerinfo().then((getlistofinservalues) async {

            print("running");
            await SyncronizationData(). savetomysqlinserdataApi(getlistofinservalues).then((value) {
              print("lengthof_contactlist"+getlistofinservalues.toString());

            });
            print("finished");
            print(contactlist);
            print("lengthof_originaldata"+getlistofinservalues.toString());

          });
        }else if(connection==true){


        }


        print("internet connection true");
      }else{
        print("no internet");
      }

    });

  }*/
  //insertJsonArray
  loaddata() async {
    noteslist = dbHelper!.getnoteslist();

    print("notelisthere_");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Databse record"),
        leading: GestureDetector(
            onTap: () async {
              //  isInternet();
            },
            child: Icon(Icons.sync)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Insertform()),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    dbHelper
                        ?.insert(NotesModel(title: "preetin", age: 22))
                        .then((value) {
                      print("data added");
                      setState(() {
                        noteslist = dbHelper!.getnoteslist();
                        print(dbHelper!.getnoteslist());
                      });
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                  },
                  child: Text("ADD")),
            ),

            /* SizedBox(
                 height: 40,
                 child: ElevatedButton(onPressed: () async{



                    await SyncronizationData().fatchallcustumerinfo().then((getlistofinservalues) async {
//  inserdataApi
                      print("running");
                      await SyncronizationData(). savetomysqlinserdataApi(getlistofinservalues).then((value) {
                        print("lengthof_contactlist"+getlistofinservalues.toString());
                      });
                      print("finished");
                      print(contactlist);
                      print("lengthof_originaldata"+getlistofinservalues.toString());


                  });



                 }, child: Text("sync")),
               ),*/
            Container(
              height: 600,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: noteslist,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int index) {
                            print("listlength" +
                                snapshot.data!.length.toString());

                            return InkWell(
                              onTap: () {
                                dbHelper!.update(NotesModel(
                                    id: snapshot.data![index].id!,
                                    title: "shanker",
                                    age: 50));
                                setState(() {
                                  noteslist = dbHelper!.getnoteslist();
                                });
                              },
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                key: ValueKey<int>(snapshot.data![index].id!),
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                  ),
                                ),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    /// delete data from database
                                    dbHelper!.delete(snapshot.data![index].id!);
                                    noteslist = dbHelper!.getnoteslist();
                                    snapshot.data!.removeAt(index).id!;
                                    print("lengthofnana" +
                                        snapshot.data![index].id.toString());
                                  });
                                },
                                child: Container(
                                  color: Colors.black38,
                                  width: 200,
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data![index].title
                                          .toString()),
                                      Text(
                                          snapshot.data![index].age.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
