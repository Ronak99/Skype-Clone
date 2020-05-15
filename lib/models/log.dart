class Log {
  int logId;
  String callerName;
  String callerPic;
  String receiverName;
  String receiverPic;
  String callStatus;
  String timestamp;

  Log({
    this.logId,
    this.callerName,
    this.callerPic,
    this.receiverName,
    this.receiverPic,
    this.callStatus,
    this.timestamp,
  });

  // to map
  Map<String, dynamic> toMap(Log log) {
    Map<String, dynamic> logMap = Map();
    logMap["log_id"] = log.logId;
    logMap["caller_name"] = log.callerName;
    logMap["caller_pic"] = log.callerPic;
    logMap["receiver_name"] = log.receiverName;
    logMap["receiver_pic"] = log.receiverPic;
    logMap["call_status"] = log.callStatus;
    logMap["timestamp"] = log.timestamp;
    return logMap;
  }

  Log.fromMap(Map logMap) {
    this.logId = logMap["log_id"];
    this.callerName = logMap["caller_name"];
    this.callerPic = logMap["caller_pic"];
    this.receiverName = logMap["receiver_name"];
    this.receiverPic = logMap["receiver_pic"];
    this.callStatus = logMap["call_status"];
    this.timestamp = logMap["timestamp"];
  }
}
