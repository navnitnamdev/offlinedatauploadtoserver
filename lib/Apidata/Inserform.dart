import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Apidata/DB/DBInserformmodal.dart';
import 'package:untitled/Apidata/Getdatamodal.dart';
import 'package:untitled/SqfliteDatabaseHelper.dart';
import 'package:untitled/SyncronizationData.dart';

class Insertform extends StatefulWidget {
  const Insertform({super.key});

  @override
  State<Insertform> createState() => _InsertformState();
}

class _InsertformState extends State<Insertform> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController mobEditingController = TextEditingController();

  List<Result> mainlist = [];

  late Future<List<DbInserformmodal>> getlistofinservalues;
  DbInserformmodal? dbInserformmodal;

  late Getdatamodal? getdatamodalres;

  SqfliteDatabaseHelper? sqfliteDatabaseHelper;

  List<DbInserformmodal> contactlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdatamodalres = Getdatamodal(status: true, message: "success", result: []);
    sqfliteDatabaseHelper = SqfliteDatabaseHelper();

    loaddata();
   // isInternet();

   ///// APi calling list get
   Future.delayed(Duration.zero, () async {
     try {
       final result =
           await InternetAddress.lookup(
           'example.com');
       if (result.isNotEmpty &&
           result[0].rawAddress.isNotEmpty) {
         this.getdataapi(context);
         FocusScope.of(context).unfocus();
       }
     } on SocketException catch (_) {
      print("no interet");
     }

    });
  }

  loaddata() async {
    setState(() {
      getlistofinservalues = sqfliteDatabaseHelper!.getinserformvalueslist();

      print("hive");
      print(getlistofinservalues);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert value form"),
      ),
      body:
      SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Enter name",
                      ),
                      controller: nameEditingController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Enter email",
                      ),
                      controller: emailEditingController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Enter Mobile no",
                      ),
                      keyboardType: TextInputType.number,
                      controller: mobEditingController,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: ()  {
                      isInternet();

                    },
                    child: Text("Submit")),
                ElevatedButton(
                    onPressed: () async {
                      await SyncronizationData()
                          .fatchallcustumerinfo()
                          .then((getlistofinservalues) async {
                        print("running");
                        await SyncronizationData()
                            .savetomysqlinserdataApi(getlistofinservalues)
                            .then((value) {
                          print("lengthof_contactlist" +
                              getlistofinservalues.toString());
                        });
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Data sync"),
                      ));
                    },
                    child: Text("data sync")),

                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      color: Colors.black12,
                      height: 200,
                      child: FutureBuilder(
                        future: getlistofinservalues!,
                        //future: mainlist,
                        builder: (context, AsyncSnapshot<List<DbInserformmodal>> snapshot) {
                          return ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data![index].name
                                          .toString()),
                                      Text(snapshot.data![index].email
                                          .toString()),
                                      Text(snapshot.data![index].mobilenumber
                                          .toString()),
                                      /*  Text(mainlist[index].emailId),
                      Text(mainlist[index].mobielNumber)*/
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ),

                Container
                  (
                    height: 300,
                    child: onlinelisting(context))



              ],
            ),
          ),
        ),
      ),
    );
  }

   Widget onlinelisting(BuildContext context){
    return Container(
      child:  ListView.builder(
          reverse: true,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: mainlist.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(mainlist[index].name
                      .toString()),
                  Text(mainlist[index].emailId
                      .toString()),
                  Text(mainlist![index].mobielNumber
                      .toString()),
                  /*  Text(mainlist[index].emailId),
                      Text(mainlist[index].mobielNumber)*/
                ],
              ),
            );
          }),
    );
  }

  Future isInternet() async {

    if(SyncronizationData.isInternet()=="true")
      print("connectionchek" + SyncronizationData.isInternet().toString());
    await SyncronizationData.isInternet().then((connection) {
      if (connection) {
        if (connection == true) {
          inserdataApi(
              context,
              nameEditingController.text.toString(),
              emailEditingController.text.toString(),
              mobEditingController.text.toString());
          print("connection here");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(" internet available and live api data saved "),
          ));
        }


      }else {

            sqfliteDatabaseHelper
                ?.insertForm(DbInserformmodal(
                name: nameEditingController.text.toString(),
                email: emailEditingController.text.toString(),
                mobilenumber:
                mobEditingController.text.toString()))
                .then((value) {
             // setState(() {});
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("not internet available locallay Successfully submitted"),


        ));
      }
    });
  }

  Future inserdataApi(
    BuildContext context,
    String name,
    String email,
    String mobile,
  ) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          );
        });

    //print("Firebase_token_sending:" + box.read("firebase_token").toString());
    var response = await http.post(
      //String   url = "https://ejalshakti.gov.in/krcpwa/api/Master/InsertTestData"
      Uri.parse("https://ejalshakti.gov.in/krcpwa/api/Master/InsertTestData"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "Name": name,
        //"LoginId": "fu_admin",
        "EmailId": email,
        //  "Password": "nic@123",
        "MobielNumber": mobile
      }),
    );
    // Get.back();
    Navigator.pop(context);

    if (response.statusCode == 200) {
      print("response_Login: " + response.body);
      //  print("Firebase_Token_res: " + box.read("firebase_token").toString());
      var responsede = jsonDecode(response.body);
      //  print("responselogin: " + responsede["Token"]);
      // print("Status code shiping address submit: " + response.statusCode.toString());
    }
    return jsonDecode(response.body);
  }

  Future getdataapi(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          );
        });

    //print("Firebase_token_sending:" + box.read("firebase_token").toString());
    var response = await http.post(
      Uri.parse("https://ejalshakti.gov.in/krcpwa/api/Master/GetTestData"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    // Get.back();
    Navigator.pop(context);

    if (response.statusCode == 200) {
      //  print("Firebase_Token_res: " + box.read("firebase_token").toString());
      getdatamodalres = Getdatamodal.fromJson(jsonDecode(response.body));
      print("response_getdata: " + response.body);
      setState(() {
        mainlist = getdatamodalres!.result;

        print("dataof" + mainlist.toString());
        // return jsonDecode(response.body);
      });
      //  print("responselogin: " + responsede["Token"]);
      // print("Status code shiping address submit: " + response.statusCode.toString());
    }
    //  return jsonDecode(response.body);
  }
}
