import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/common_switch.dart';
import '../utils/uidata.dart';


class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "Setting",
      showDrawer: false,
      showFAB: false,
      backGroundColor: Colors.grey.shade300,
      bodyData: bodyData(context),
      actionFirstIcon: null,
    );
  }

  Widget bodyData(BuildContext context) => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1
              
            ],
          ),
        ),
      );
}
