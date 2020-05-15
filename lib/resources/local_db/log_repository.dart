import 'package:skype_clone/models/log.dart';
import 'package:skype_clone/resources/local_db/db/hive_methods.dart';
import 'package:skype_clone/resources/local_db/db/sqflite_methods.dart';
import 'package:skype_clone/resources/local_db/log_methods.dart';
import 'package:meta/meta.dart';

class LogRepository implements LogMethods {
  var dbObject;
  bool isHive;

  LogRepository({@required this.isHive}) {
    print(isHive ? "Using HIVE" : "Using SQFLITE");
    dbObject = isHive ? HiveMethods() : SqfliteMethods();
  }

  @override
  init() => dbObject.init();

  @override
  addLogs(Log log) => dbObject.addLogs(log);

  @override
  deleteLogs(int logId) => dbObject.deleteLogs(logId);

  @override
  getLogs() => dbObject.getLogs();

  @override
  close() => dbObject.close();
}
