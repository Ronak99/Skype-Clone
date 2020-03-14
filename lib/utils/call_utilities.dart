import 'package:skype_clone/models/call.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/call_methods.dart';
import 'package:skype_clone/screens/callscreens/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({
    @required User from,
    @required User to,
    @required context,
  }) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    // make call
    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
