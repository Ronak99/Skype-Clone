import 'package:skype_clone/models/log.dart';

abstract class LogMethods {
  init();

  addLogs(Log log);

  Future<List<Log>> getLogs();

  deleteLogs(int logId);

  close();
}
