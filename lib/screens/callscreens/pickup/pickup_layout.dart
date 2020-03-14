import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/models/call.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/call_methods.dart';
import 'package:skype_clone/screens/callscreens/pickup/pickup_screen.dart';

class PickupLayout extends StatefulWidget {
  final Widget scaffold;

  PickupLayout({Key key, this.scaffold}) : super(key: key);

  @override
  _PickupLayoutState createState() => _PickupLayoutState();
}

class _PickupLayoutState extends State<PickupLayout> {
  final CallMethods callMethods = CallMethods();
  UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return (userProvider != null && userProvider.getUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.getUser.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data != null) {
                Call call = Call.fromMap(snapshot.data.data);
                if (!call.hasDialled) {
                  return PickupScreen(call: call);
                }
                return widget.scaffold;
              }

              return widget.scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
