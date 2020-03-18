import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {
  //routes
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String homeRoute = "/home";
  static const String groupRoute = "/group";
  static const String groupAddRoute = "/add group";
  static const String friendRoute = "/friend";
  static const String friendAddRoute = "/add friend";
  static const String settingRoute = "/setting";

  //strings
  static const String appName = "Group Money";

  static int home_selected_index = 0;
  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";

  //images
  static const String default_profile = "assets/non_profile.png";

  //login
  static const String enter_code_label = "Phone Number";
  static const String enter_code_hint = "10 Digit Phone Number";
  static const String enter_otp_label = "OTP";
  static const String enter_otp_hint = "4 Digit OTP";
  static const String get_otp = "Get OTP";
  static const String resend_otp = "Resend OTP";
  static const String login = "Login";
  static const String enter_valid_number = "Enter 10 digit phone number";
  static const String enter_valid_otp = "Enter 4 digit otp";

  //gneric
  static const String error = "Error";
  static const String success = "Success";
  static const String ok = "OK";
  static const String forgot_password = "Forgot Password?";
  static const String something_went_wrong = "Something went wrong";
  static const String coming_soon = "Coming Soon";

  static const MaterialColor ui_kit_color = Colors.grey;

//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}

var selected_index = 0;

Random random = Random();

class Group {
  String title;
  String description;
  String target_amount;
  String current_ammount;
  String created_time;
  User user;

  Group(this.title,
      this.description,
      this.target_amount,
      this.current_ammount,
      this.created_time,
      this.user);
}

class User {
  String name;
  String phoneNumber;
  bool isOnLine;

  User(this.name,
      this.phoneNumber,
      this.isOnLine);
}

List<User> users = List<User>.generate(13, (index) => User(
    names[random.nextInt(10)], 
    phones[random.nextInt(10)],
    random.nextBool(),
    )
);

List<Group> groups = List<Group>.generate(13, (index) =>
  Group(
    "Group ${random.nextInt(20)}",
    details[random.nextInt(10)],
    "${random.nextInt(300)}",
    "${random.nextInt(300)}",
    "${random.nextInt(50)}min ago",
    users[random.nextInt(10)],
  )
);



List names = [
  "Ling Waldner",
  "Gricelda Barrera",
  "Lenard Milton",
  "Bryant Marley",
  "Rosalva Sadberry",
  "Guadalupe Ratledge",
  "Brandy Gazda",
  "Kurt Toms",
  "Rosario Gathright",
  "Kim Delph",
  "Stacy Christensen",
];

List phones = [
  "+45154589789",
  "+12459456715",
  "+68995454567",
  "+65845656475",
  "+98454523344",
  "+35457841569",
  "+58455124565",
  "+15786646879",
  "+29456689458",
  "+01245689964",
  "+58948745455",
];

List details = [
  "Hey, how are you doing?",
  "Are you available tomorrow?",
  "It's late. Go to bed!",
  "This cracked me up 😂😂",
  "Flutter Rocks!!!",
  "The last rocket🚀",
  "Griezmann signed for Barca❤️❤️",
  "Will you be attending the meetup tomorrow?",
  "Are you angry at something?",
  "Let's make a UI serie.",
  "Can i hear your voice?",
];