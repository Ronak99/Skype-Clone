import 'package:flutter/material.dart';
import 'package:skype_clone/models/log.dart';
import 'package:skype_clone/resources/local_db/repository/log_repository.dart';
import 'package:skype_clone/utils/universal_variables.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Center(
        child: FlatButton(
          child: Text("Click Me"),
          onPressed: () {
            LogRepository.init(isHive: false);
            LogRepository.addLogs(Log());
          },
        ),
      ),
    );
  }
}
