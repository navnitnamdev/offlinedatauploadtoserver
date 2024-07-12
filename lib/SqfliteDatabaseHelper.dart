import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:untitled/Apidata/DB/DBInserformmodal.dart';
import 'package:untitled/NotesModel.dart';

import 'Apidata/jsonlive/Dashboardmodal.dart';
import 'Apidata/jsonlive/Localmodaldashboard.dart';

class SqfliteDatabaseHelper {
  SqfliteDatabaseHelper.internal();

  static final SqfliteDatabaseHelper instance =
      new SqfliteDatabaseHelper.internal();

  factory SqfliteDatabaseHelper() => instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabse();
    return _db;
  }

  initDatabse() async {
    io.Directory documentryDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentryDirectory.path, 'JJMRecord.db');
    var db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE jjmtable(id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, age INTEGER NOT NULL , email TEXT)");
    await db.execute(
        "CREATE TABLE Inserformtable(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, email Text , mobilenumber TEXT)");
    await db.execute(
        "CREATE TABLE dashboardlisttable(id INTEGER PRIMARY KEY AUTOINCREMENT , MenuId Text)");
  }

  //jjm insert dashboard
  Future<void> dashboardinsertJsonArray(Localmodaldashboard model) async {
    var dbClient = await db;
    await dbClient!.insert('dashboardlisttable', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('jjmtable', notesModel.toMap());
    return notesModel;
  }

  Future<DbInserformmodal> insertForm(DbInserformmodal dbInserformmodal) async {
    var dbClient = await db;
    await dbClient!.insert('Inserformtable', dbInserformmodal.toMap());
    return dbInserformmodal;
  }

  Future<List<NotesModel>> getnoteslist() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('jjmtable');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  // original data fatch jjm
  Future<List<Dashboardmodal>> fatchoriginallistfrom_sqflite() async {
    var dbClient = await db;

    var data = await dbClient!.rawQuery("SELECT * FROM dashboardlisttable");
    List<Dashboardmodal> dashboardmodal =
        data.map((e) => Dashboardmodal.fromJson(e)).toList();
    return dashboardmodal;
  }

  /* Future<List<DbInserformmodal>> getinserformvalueslist() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('Inserformtable');
    return queryResult.map((e) => DbInserformmodal.fromMap(e)).toList();
  }*/

  Future<List<DbInserformmodal>> getinserformvalueslist() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('Inserformtable');
    return queryResult.map((e) => DbInserformmodal.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('jjmtable', where: 'id = ?', whereArgs: [id]);
  }

  // update
  Future<int> update(NotesModel notesModel) async {
    var dbClient = await db;
    return await dbClient!.update('jjmtable', notesModel.toMap(),
        where: 'id = ?', whereArgs: [notesModel.id]);
  }
}
