import 'package:flutter/material.dart';
import 'package:moneygroup/utils/uidata.dart';
import 'package:moneygroup/view/mainView.dart';
import 'view/loginView.dart';
import 'view/signupView.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final materialApp = MaterialApp(
    initialRoute: UIData.loginRoute,
    routes: <String, WidgetBuilder>{
      UIData.loginRoute: (BuildContext context) => LoginView(),
      UIData.signupRoute: (BuildContext context) => SignupView(),
      UIData.homeRoute: (BuildContext context) => MainView(),
    },
  );

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}
