import 'package:flutter/material.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';
import '../utils/components.dart';

class LoginView extends StatelessWidget {

  final user_name_in = TextEditingController();
  final user_pwd_in = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _body(context)
    );
  }

  _body(BuildContext context) => SingleChildScrollView (
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        mainHeader(), 
        SizedBox(height: 10),        
        borderedTextField(user_name_in, TextInputType.number, false, "Phone Number", UIData.largePadding), 
        SizedBox(height: 30),
        secureTextField(user_pwd_in, true, TextInputType.emailAddress, "Password", UIData.largePadding),
        SizedBox(height: 50),
        roundColorButton("Login", double.infinity, Colors.grey[200], Colors.black, 30, () => {normalLogin(context)}),
        SizedBox(height: 20),
        clickLable("Don`t you have an account? Sign Up", Colors.black38, () => {
          Navigator.pushNamed(context, UIData.signupRoute)
        }),
        ],
    )
  );

  Function normalLogin(BuildContext context) {    
    
    app_status_index = 0;
    Navigator.of(context, rootNavigator: true).pushReplacementNamed(UIData.homeRoute);
    /*
    if (user_name_in.text == '' || user_pwd_in.text == '') {
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
        'email': user_name_in.text, 
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
                  onPressed: () => {
                    // Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
                    // Navigator.pushNamed(context, '/home', arguments: ScreenArguments(user_name_in.text, user_pwd_in.text)),
                    // Navigator.of(context, rootNavigator: true).pushReplacementNamed('/home', arguments: user_name_in.text)
                    
                  },
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
                  // onPressed: () => Navigator.pop(context),
                  onPressed: () => {
                    // Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
                    // Navigator.pushNamed(context, '/home'),
                    
                    Navigator.of(context, rootNavigator: true).pushReplacementNamed('/home', arguments: user_name_in.text)
                    
                  },
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
    */
  }
}


