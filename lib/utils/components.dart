import 'dart:wasm';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'uidata.dart';

mainHeader() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      SizedBox(height: 100),
      Image.asset('assets/logo.png',height: 150,width: 150,),
      SizedBox(height: 30),
      Text(
        UIData.appName,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green, fontSize: 30),
      ),
      SizedBox(height: 50),
    ],
  );

loginTextField(TextEditingController controller, bool obscureText, TextInputType keyboardType, String label ) => Container(
  
  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
  child: TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      // maxLength: 19,
      style: TextStyle(
          color: Colors.black),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(6.0),
          ),),
      ),
    ),
);


roundColorButton(String label, Color buttonColor, Color labelColor, double padding, Function action) => Container(
 
  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: padding),
  width: double.infinity,
  child: RaisedButton(
    padding: EdgeInsets.all(12.0),
    shape: StadiumBorder(),
    child: new GestureDetector(
      onTap: action,
      child: Text(
        label,
        style: TextStyle(color: labelColor),
        ),
                          
    ),
    color: buttonColor,
    onPressed: () {},
  ),
);

clickLable(String label, Color color, Function action) => GestureDetector(
  onTap: action,
  child: Text(
    label,
    style: TextStyle(color: color),
    ),
                      
);

alertStyle() => AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 200),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.red,
  ),
);


class MyUIData {
  static int home_selected_index = 0;
}