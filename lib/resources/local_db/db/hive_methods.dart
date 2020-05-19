import 'package:skype_clone/models/log.dart';
import 'package:skype_clone/resources/local_db/interface/log_interface.dart';

class HiveMethods implements LogInterface {
  @override
  addLogs(Log log) {
    print("Adding values to hive db");
    return null;
  }

  @override
  close() {
    // TODO: implement close
    return null;
  }

  @override
  deleteLogs(int logId) {
    // TODO: implement deleteLogs
    return null;
  }

  @override
  Future<List<Log>> getLogs() {
    // TODO: implement getLogs
    return null;
  }

  @override
  init() {
    print("initialized hive db");
    return null;
  }
}
