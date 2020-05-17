import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:skype_clone/models/log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:skype_clone/resources/local_db/interface/log_interface.dart';

class SqliteMethods implements LogInterface {
  static Database _db;

  //database name
  static const String DB_NAME = 'LogDB';

  // table name
  static const String TABLENAME = 'CallLogs';

  //columns
  static const String ID = 'log_id';
  static const String CALLER_NAME = 'caller_name';
  static const String CALLER_PIC = 'caller_pic';
  static const String RECEIVER_NAME = 'receiver_name';
  static const String RECEIVER_PIC = 'receiver_pic';
  static const String CALL_STATUS = 'call_status';
  static const String TIMESTAMP = 'timestamp';

  Future<Database> get db async {
    if (_db != null) {
      // print("db is not null");
      return _db;
    }
    print("db was null, now awaiting it");
    _db = await init();
    return _db;
  }

  @override
  init() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    String createTableQuery =
        "CREATE TABLE $TABLENAME ($ID INTEGER PRIMARY KEY, $CALLER_NAME TEXT, $CALLER_PIC TEXT, $RECEIVER_NAME TEXT, $RECEIVER_PIC TEXT, $CALL_STATUS TEXT, $TIMESTAMP TEXT)";

    await db.execute(createTableQuery);
    print("creating table");
  }

  @override
  addLogs(Log log) async {
    var dbClient = await db;
    await dbClient.insert(TABLENAME, log.toMap(log));
  }

  @override
  Future<List<Log>> getLogs() async {
    try {
      var dbClient = await db;
      List<Map> maps = await dbClient.query(TABLENAME, columns: [
        ID,
        CALLER_NAME,
        CALLER_PIC,
        RECEIVER_NAME,
        RECEIVER_PIC,
        CALL_STATUS,
        TIMESTAMP,
      ]);
      //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
      List<Log> logList = [];
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          var logMap = maps[i];
          logList.insert(0, Log.fromMap(logMap));
        }
      }
      return logList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  deleteLogs(int logId) async {
    var client = await db;

    return await client.delete(TABLENAME, where: '$ID = ?', whereArgs: [logId]);
  }

  @override
  close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
