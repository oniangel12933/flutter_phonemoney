import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../utils/functions.dart';
import '../utils/components.dart';
import '../utils/uiData.dart';

class SignupView extends StatelessWidget {
  
  final user_name_in = TextEditingController();
  final user_phone_in = TextEditingController();
  final user_pwd_in = TextEditingController();
  final user_pwd_confirm_in = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    // final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _body(context),
    );
  }

  _body(BuildContext context) => SingleChildScrollView (
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        mainHeader(), 
        SizedBox(height: 10),
        borderedTextField(user_name_in, TextInputType.emailAddress, false, "User Name", UIData.largePadding),         
        SizedBox(height: 30),
        borderedTextField(user_phone_in, TextInputType.number, false, "Phone Number", UIData.largePadding),   
        SizedBox(height: 30),
        secureTextField(user_pwd_in, true, TextInputType.emailAddress, "Password", UIData.largePadding),
        SizedBox(height: 30),
        secureTextField(user_pwd_confirm_in, true, TextInputType.emailAddress, "Confirm Password", UIData.largePadding),
        SizedBox(height: 30),
        roundColorButton("Sign Up", double.infinity, Colors.grey[200], Colors.black, 30, () => {signup(context)}),
        SizedBox(height: 30.0),
        clickLable(" Do you already have an account? Sign In", Colors.black38, () => {
          Navigator.pop(context)
        }),
        SizedBox(height: 30),
        ],
    )
  );

  Function signup(BuildContext context) {

    if (user_name_in.text == '' || user_phone_in.text == '' || user_pwd_confirm_in.text == '' || user_pwd_in.text == '') {
      Alert(
        context: context,
        style: alertStyle(),
        type: AlertType.warning,
        title: "Warning",
        desc: "Please fill all parameters",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
            height: 40,
          )
        ],
      ).show();
    }
    else {
      
      var params = {
        'phone': user_phone_in.text, 
        'password': user_pwd_in.text,
        'device_token':''};
                      
      postApiCall(params, 
        "http://placetracker.net/RestAPIs/loginRequest").then((value) {
          // Run extra code here
          
          if (value['status'] as bool)
          {
            Alert(
            context: context,
            style: alertStyle(),
            type: AlertType.info,
            title: "Success",
            desc: value['message'] as String,
            buttons: [
              DialogButton(
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
                height: 40,
              )
            ],
          ).show();
          }
          else
          {
            Alert(
            context: context,
            style: alertStyle(),
            type: AlertType.info,
            title: "Failed",
            desc: value['message'] as String,
            buttons: [
              DialogButton(
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
                height: 40,
              )
            ],
          ).show();
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