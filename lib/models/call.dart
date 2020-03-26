class Call {
  String callerId;
  String callerName;
  String callerPic;
  String receiverId;
  String receiverName;
  String receiverPic;
  String channelId;
  bool hasDialled;

  Call({
    this.callerId,
    this.callerName,
    this.callerPic,
    this.receiverId,
    this.receiverName,
    this.receiverPic,
    this.channelId,
    this.hasDialled,
  });

  // to map
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap["caller_id"] = call.callerId;
    callMap["caller_name"] = call.callerName;
    callMap["caller_pic"] = call.callerPic;
    callMap["receiver_id"] = call.receiverId;
    callMap["receiver_name"] = call.receiverName;
    callMap["receiver_pic"] = call.receiverPic;
    callMap["channel_id"] = call.channelId;
    callMap["has_dialled"] = call.hasDialled;
    return callMap;
  }

  Call.fromMap(Map callMap) {
    this.callerId = callMap["caller_id"];
    this.callerName = callMap["caller_name"];
    this.callerPic = callMap["caller_pic"];
    this.receiverId = callMap["receiver_id"];
    this.receiverName = callMap["receiver_name"];
    this.receiverPic = callMap["receiver_pic"];
    this.channelId = callMap["channel_id"];
    this.hasDialled = callMap["has_dialled"];
  }
}
