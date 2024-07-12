import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get/get.dart';
import 'package:untitled/Apidata/Getdatamodal.dart';
import 'package:untitled/NotesModel.dart';
import 'package:untitled/SqfliteDatabaseHelper.dart';

import 'Apidata/DB/DBInserformmodal.dart';
import 'package:http/http.dart' as http;

class SyncronizationData {
  static Future<bool> isInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      if (await DataConnectionChecker().hasConnection) {
        print("mobile data detect");
        return true;
      } else {
        print("no internet");
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      if (await DataConnectionChecker().hasConnection) {
        print("wifi data detect");
        return true;
      } else {
        print("no wifi internet");
        return false;
      }
    } else {
      print("no wifi and no mobile data");
      return false;
    }
  }

  final conn = SqfliteDatabaseHelper.instance;

  Future<List<NotesModel>> getnoteslist() async {
    var dbClient = await conn.db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('jjmtable');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<List<DbInserformmodal>> getinserformvalueslist() async {
    //var dbClient = await db;
    var dbClient = await conn.db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('Inserformtable');
    return queryResult.map((e) => DbInserformmodal.fromMap(e)).toList();
  }

  Future<List<DbInserformmodal>> fatchallcustumerinfo() async {
    //var dbClient = await db;
    var dbClient = await conn.db;
    List<DbInserformmodal> contactlist = [];
    try {
      final maps = await dbClient!.query('Inserformtable');
      for (var item in maps) {
        contactlist.add(DbInserformmodal.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactlist;
  }

  Future savetomysqlinserdataApi(List<DbInserformmodal> contactlist) async {
    for (int i = 0; i < contactlist.length; i++) {
      print("ddddd" + contactlist[i].name.toString());
      Map<String, dynamic> data = {
        "Name": contactlist[i].name.toString(),
        "EmailId": contactlist[i].email.toString(),
        "MobielNumber": contactlist[i].mobilenumber.toString(),
      };
      print("nova" + contactlist[i].name.toString());
      final response = await http.post(
          //String   url = "https://ejalshakti.gov.in/krcpwa/api/Master/InsertTestData"
          Uri.parse(
              "https://ejalshakti.gov.in/krcpwa/api/Master/InsertTestData"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        print("response_ofsyncronization: " + response.body);
        //  print("Firebase_Token_res: " + box.read("firebase_token").toString());
        //   var responsede = jsonDecode(response.body);
        /*   print("responselogin: " + responsede);*/
        // print("Status code shiping address submit: " + response.statusCode.toString());
      }

      //return contactlist;
    }

    /* body: jsonEncode({
        "Name": name,
        //"LoginId": "fu_admin",
        "EmailId": email,
        //  "Password": "nic@123",
        "MobielNumber": mobile
      }),*/
    //  );
    // Get.back();
    // Navigator.pop(context);
  }
}
