import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
  bool user_phone_status = true;
  bool user_pwd_status = true;

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
        borderedTextField(user_phone_in, user_phone_status, TextInputType.number, false, "Phone Number", UIData.largePadding, textFieldNull()), 
        SizedBox(height: 30),
        secureTextField(user_pwd_in, user_pwd_status, true, TextInputType.emailAddress, "Password", UIData.largePadding),
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
    
    if (user_phone_in.text == "")  {
      user_phone_status = false;
    } 
    else {
      user_phone_status = true;
    }
    if (user_pwd_in.text == "")  {
      user_pwd_status = false;
    }
    else {
      user_pwd_status = true;
    }

    setState(() {});

    if (user_phone_status && user_pwd_status) {
      var params = {
        'phone_number': user_phone_in.text,
        'password': user_pwd_in.text};

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator(),);
          });
                      
      postApiCall(params, AppData.baseURL + AppData.loginApi).then((value) {
          // Run extra code here
          
          if (value['status'] as bool)
          {
            final data = value['data'] as Map<String, dynamic>;
            AppData.user_info = User.fromJson(data['profile'] as Map<String, dynamic>);
            
            Navigator.pop(context);
            app_status_index = 0;
            // Navigator.of(context, rootNavigator: true).pushReplacementNamed(UIData.homeRoute);
            Navigator.pushNamed(context, UIData.homeRoute);
          }
          else
          {
            Navigator.pop(context);
            showAlert(context, AlertType.error, value['message'] as String, "Close", () => {Navigator.pop(context)});
          }
        }, onError: (error) {
          print(error);
        });
    }
  }
}


