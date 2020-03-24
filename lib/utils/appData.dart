import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moneygroup/utils/uiData.dart';


class AppData {
  
  /// strings
  static const String baseURL = "https://dev.mywebsite.cm/apis.php?action=";
  static const String loginApi = "login";
  static const String signupApi = "register";
  static const String createGroupApi = "creategroup";
  static const String createContributeApi = "createcontribute";
  static const String addMemberApi = "addmember";
  static const String addPhoneApi = "addphone";

  /// user datas
  static User user_info;
}

var app_status_index = 0;
var selected_group_index = 0;
var selected_contribute_index = 0;

Random random = Random();

class Group {
  final String id;
  final User created_user_id;
  final String title;
  final String description;
  final String created_time;
  final String number_of_members;

  Group(this.id,
      this.created_user_id,
      this.title,
      this.description,
      this.created_time,
      this.number_of_members);
  
  Group.fromJson(Map<String, dynamic> json)
      : id = json['group_id'],
        created_user_id = json['created_user_id'],
        title = json['title'],
        description = json['description'],
        created_time = json['created_time'],
        number_of_members = json['number_of_members'];
}

class User {
  final String id;
  final String name;
  final String mainPhone;
  final String otherPhones;
  bool isOnLine;

  User(this.id,
      this.name,
      this.mainPhone,
      this.otherPhones,
      this.isOnLine);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        mainPhone = json['main_phone'],
        otherPhones = json['other_phones'];
}

class Contribute {
  String id;
  String title;
  String description;
  String target_amount;
  String current_amount;
  String created_time;
  String end_time;
  String beneficiary_name;
  String beneficiary_number;
  User created_user;

  Contribute(this.id,
      this.title,
      this.description,
      this.target_amount,
      this.current_amount,
      this.created_time,
      this.end_time,
      this.beneficiary_name,
      this.beneficiary_number,
      this.created_user
      );
}

class Report {

  String id;
  ReportType type;
  String optional_val;
  String created_time;
  User created_user;

  Report(this.id,
        this.type,
        this.optional_val,
        this.created_time,
        this.created_user);
}

class Donate {
  
  User user;
  String amount;
  String time;

  Donate(this.user,
        this.amount,
        this.time);

}

enum ReportType {
  member_add,
  contribute_creat,
  contribute_join,
  contribute_end
}


List<User> default_users;
List<Group> default_groups;
List<Contribute> default_contributes;
List<Report> default_reports;
List<Donate> default_donates;

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});
 
  String title;
  IconData icon;
}

List<CustomPopupMenu> group_menu_list = <CustomPopupMenu>[
  CustomPopupMenu(title: UIData.menuNewGroup, icon: Icons.home),
  CustomPopupMenu(title: UIData.menuAccount, icon: Icons.bookmark),
  CustomPopupMenu(title: UIData.menuLogOut, icon: Icons.settings),
];

List<CustomPopupMenu> member_menu_list = <CustomPopupMenu>[
  CustomPopupMenu(title: UIData.menuNewContribute, icon: Icons.home),
  CustomPopupMenu(title: UIData.menuNewMember, icon: Icons.bookmark),
];

List<CustomPopupMenu> donate_menu_list = <CustomPopupMenu>[
  CustomPopupMenu(title: UIData.menuViewBeneficiary, icon: Icons.home),
  CustomPopupMenu(title: UIData.menuRequestSettlement, icon: Icons.bookmark),
];


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
  "This cracked me up",
  "Flutter Rocks!!!",
  "The last rocket",
  "Griezmann signed for Barca❤️❤️",
  "Will you be attending the meetup tomorrow?",
  "Are you angry at something?",
  "Let's make a UI serie.",
  "Can i hear your voice?",
];

Function textFieldNull() {}