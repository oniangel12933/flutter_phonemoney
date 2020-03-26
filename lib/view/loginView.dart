import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';
import '../utils/functions.dart';
import '../utils/components.dart';

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final user_phone_in = TextEditingController();
  final user_pwd_in = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  bool user_phone_status = true;
  bool user_pwd_status = true;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: phoneFocus,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[100], body: _body(context));
  }

  _body(BuildContext context) => KeyboardActions(
      config: _buildConfig(context),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          mainHeader(),
          SizedBox(height: 10),
          borderedNumberTextField(
              phoneFocus,
              user_phone_in,
              user_phone_status,
              TextInputType.number,
              false,
              "Phone Number",
              UIData.largePadding,
              textFieldNull()),
          SizedBox(height: 30),
          secureTextField(user_pwd_in, user_pwd_status, true,
              TextInputType.emailAddress, "Password", UIData.largePadding),
          SizedBox(height: 50),
          roundColorButton("Login", double.infinity, Colors.grey[200],
              Colors.black, 30, () => {normalLogin(context)}),
          SizedBox(height: 20),
          clickLable("Don`t you have an account? Sign Up", Colors.black38,
              () => {Navigator.pushNamed(context, UIData.signupRoute)}),
        ],
      )));

  Function normalLogin(BuildContext context) {
    if (user_phone_in.text == "") {
      user_phone_status = false;
    } else {
      user_phone_status = true;
    }
    if (user_pwd_in.text == "") {
      user_pwd_status = false;
    } else {
      user_pwd_status = true;
    }

    setState(() {});

    if (user_phone_status && user_pwd_status) {
      var params = {
        'phone_number': user_phone_in.text,
        'password': user_pwd_in.text
      };

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      postApiCall(params, AppData.baseURL + AppData.loginApi).then((value) {
        // Run extra code here

        if (value['status'] as bool) {
          final data = value['data'] as Map<String, dynamic>;
          AppData.user_info =
              User.fromJson(data['profile'] as Map<String, dynamic>);
          phoneNumbers = [];
          int index = 0;
          phoneNumbers.add(PhoneNumber(index, AppData.user_info.mainPhone));
          index++;
          if (AppData.user_info.otherPhones != "") {
            final other_phones = AppData.user_info.otherPhones.split(",");
            other_phones.map((i) {
              final phone = PhoneNumber(index, i);
              phoneNumbers.add(PhoneNumber(index, i));
              index++;
            }).toList();
          }
          if (data['groups'] != null) {
            (data['groups'] as List).map((i) {
              final group = Group.fromJson(i as Map<String, dynamic>);
              if (groups == null) {
                groups = [group];
              } else {
                groups.add(group);
              }
            }).toList();

            groups.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
          }

          if (data['reports'] != null) {
            (data['reports'] as List).map((i) {
              final report = Report.fromJson(i as Map<String, dynamic>);
              if (reports == null) {
                reports = [report];
              } else {
                reports.add(report);
              }
            }).toList();

            reports.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
          }

          Navigator.pop(context);
          app_status_index = 0;
          // Navigator.of(context, rootNavigator: true).pushReplacementNamed(UIData.homeRoute);
          Navigator.pushNamed(context, UIData.homeRoute);
        } else {
          Navigator.pop(context);
          showAlert(context, AlertType.error, value['message'] as String,
              "Close", () => {Navigator.pop(context)});
        }
      }, onError: (error) {
        print(error);
      });
    }
  }
}
