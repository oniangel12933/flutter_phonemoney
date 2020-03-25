import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../utils/functions.dart';
import '../utils/components.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';

class SignupView extends StatefulWidget {
  @override
  SignupViewState createState() => SignupViewState();
}

class SignupViewState extends State<SignupView> {
  final user_name_in = TextEditingController();
  final user_phone_in = TextEditingController();
  final user_pwd_in = TextEditingController();
  final user_pwd_confirm_in = TextEditingController();

  bool user_name_status = true;
  bool user_phone_status = true;
  bool user_pwd_status = true;
  bool user_pwd_confirm_status = true;

  @override
  Widget build(BuildContext context) {
    // final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _body(context),
    );
  }

  _body(BuildContext context) => SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          mainHeader(),
          SizedBox(height: 10),
          borderedTextField(
              user_name_in,
              user_name_status,
              TextInputType.emailAddress,
              false,
              "User Name",
              UIData.largePadding,
              textFieldNull()),
          SizedBox(height: 30),
          borderedTextField(
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
          SizedBox(height: 30),
          secureTextField(
              user_pwd_confirm_in,
              user_pwd_confirm_status,
              true,
              TextInputType.emailAddress,
              "Confirm Password",
              UIData.largePadding),
          SizedBox(height: 30),
          roundColorButton("Sign Up", double.infinity, Colors.grey[200],
              Colors.black, 30, () => {signup(context)}),
          SizedBox(height: 30.0),
          clickLable(" Do you already have an account? Sign In", Colors.black38,
              () => {Navigator.pop(context)}),
          SizedBox(height: 30),
        ],
      ));

  Function signup(BuildContext context) {
    if (user_name_in.text == '') {
      user_name_status = false;
    } else {
      user_name_status = true;
    }
    if (user_phone_in.text == '') {
      user_phone_status = false;
    } else {
      user_phone_status = true;
    }

    if (user_pwd_in.text == '') {
      user_pwd_status = false;
    } else {
      user_pwd_status = true;
    }
    if (user_pwd_confirm_in.text == '') {
      user_pwd_confirm_status = false;
    } else {
      if (user_pwd_in.text != user_pwd_confirm_in.text) {
        user_pwd_confirm_status = false;
      } else {
        user_pwd_confirm_status = true;
      }
    }

    setState(() {});

    if (user_name_status &&
        user_phone_status &&
        user_pwd_status &&
        user_pwd_confirm_status) {
      var params = {
        'name': user_name_in.text,
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

      postApiCall(params, AppData.baseURL + AppData.signupApi).then((value) {
        // Run extra code here

        if (value['status'] as bool) {
          final data = value['data'] as Map<String, dynamic>;
          AppData.user_info =
              User.fromJson(data['profile'] as Map<String, dynamic>);
          showAlert(
              context,
              AlertType.success,
              value['message'] as String,
              "Done",
              () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, UIData.homeRoute)
                  });
        } else {
          showAlert(
              context,
              AlertType.error,
              value['message'] as String,
              "Close",
              () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, UIData.homeRoute)
                  });
        }
      }, onError: (error) {
        print(error);
      });
    }
  }
}

class ScreenArguments {
  final String name;
  final String password;

  ScreenArguments(this.name, this.password);
}
