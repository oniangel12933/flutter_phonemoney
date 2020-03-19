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

secureTextField(TextEditingController controller, bool obscureText, TextInputType keyboardType, String label, double padding) => new Container(
  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: padding),
  child: new TextField( 
    controller: controller,
    obscureText: true,
    keyboardType: TextInputType.text,

    decoration: new InputDecoration(
      // hintText: 'Type here about new group',
      labelText: label,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      enabledBorder: const OutlineInputBorder(
        // width: 0.0 produces a thin "hairline" border
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      border: const OutlineInputBorder(),
  )
));

borderedTextField(TextEditingController controller, TextInputType keyboardType, bool multiLineEnable, String label, double padding, Function action) => new Container(
  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: padding),
  child: new TextField( 
    onChanged: action,
    controller: controller,
    keyboardType: keyboardType,
    maxLines: multiLineEnable ? null : 1,
    decoration: new InputDecoration(
      // hintText: 'Type here about new group',
      labelText: label,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      enabledBorder: const OutlineInputBorder(
        // width: 0.0 produces a thin "hairline" border
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      border: const OutlineInputBorder(),
  )
));

roundColorButton(String label, double width, Color buttonColor, Color labelColor, double padding, Function action) => Container(
  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: padding),
  width: width,
  child: RaisedButton(
    padding: EdgeInsets.all(12.0),
    shape: StadiumBorder(),
    disabledColor: Colors.blue,
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