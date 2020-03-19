import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';


var app_status_index = 0;
var selected_index = 0;

Random random = Random();

class Group {
  String id;
  String title;
  String description;
  String number_of_members;
  String created_time;
  User created_user;
  List<User> members;
  List<Contribute> contributes;

  Group(this.id,
      this.title,
      this.description,
      this.number_of_members,
      this.created_time,
      this.created_user,
      this.members,
      this.contributes);
}

class User {
  String id;
  String name;
  String phoneNumber;
  bool isOnLine;

  User(this.id,
      this.name,
      this.phoneNumber,
      this.isOnLine);
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

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});
 
  String title;
  IconData icon;
}

List<CustomPopupMenu> group_menu_list = <CustomPopupMenu>[
  CustomPopupMenu(title: 'New Group', icon: Icons.home),
  CustomPopupMenu(title: 'Account', icon: Icons.bookmark),
  CustomPopupMenu(title: 'Log Out', icon: Icons.settings),
];

List<CustomPopupMenu> member_menu_list = <CustomPopupMenu>[
  CustomPopupMenu(title: 'New Contribute', icon: Icons.home),
  CustomPopupMenu(title: 'New Member', icon: Icons.bookmark),
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