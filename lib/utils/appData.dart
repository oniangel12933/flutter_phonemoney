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
  static const String getDetailApi = "getdetail";
  static const String removeMemberApi = "removemember";
  static const String addDonateApi = "adddonate";
  static const String reloadApi = "reloaddata";

  /// user datas
  static User user_info;
}

var app_status_index = 0;
var selected_group_index = 0;
var selected_contribute_index = 0;

Random random = Random();

class Group {
  final String id;
  final String created_user_id;
  final String title;
  final String description;
  final String created_time;
  final String number_of_members;

  Group(this.id, this.created_user_id, this.title, this.description,
      this.created_time, this.number_of_members);

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
  final String isOnLine;

  User(this.id, this.name, this.mainPhone, this.otherPhones, this.isOnLine);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        mainPhone = json['main_phone'],
        otherPhones = json['other_phones'],
        isOnLine = json['isOnLine'];
}

class Member {
  final String id;
  final String group_id;
  final String name;
  final String phone_number;
  final String owner_status;
  final String isOnLine;

  Member(this.id, this.group_id, this.name, this.phone_number,
      this.owner_status, this.isOnLine);

  Member.fromJson(Map<String, dynamic> json)
      : id = json['member_id'],
        group_id = json['group_id'],
        name = json['name'],
        phone_number = json['phone_number'],
        owner_status = json['owner_status'],
        isOnLine = json['isOnLine'];
}

class Contribute {
  final String id;
  final String created_group_id;
  final String created_user_id;
  final String title;
  final String description;
  final String target_amount;
  final String current_amount;
  final String created_time;
  final String end_time;
  final String beneficiary_name;
  final String beneficiary_phone;
  final String end_status;

  Contribute(
      this.id,
      this.created_group_id,
      this.created_user_id,
      this.title,
      this.description,
      this.target_amount,
      this.current_amount,
      this.created_time,
      this.end_time,
      this.beneficiary_name,
      this.beneficiary_phone,
      this.end_status);

  Contribute.fromJson(Map<String, dynamic> json)
      : id = json['contribute_id'],
        created_group_id = json['created_group_id'],
        created_user_id = json['created_user_id'],
        title = json['title'],
        description = json['description'],
        target_amount = json['target_amount'],
        current_amount = json['current_amount'],
        created_time = json['created_time'],
        end_time = json['end_time'],
        beneficiary_name = json['beneficiary_name'],
        beneficiary_phone = json['beneficiary_phone'],
        end_status = json['end_status'];
}

class Report {
  final String id;
  final String sender_id;
  final String sender_name;
  final String receiver_id;
  final String type;
  final String optional_val;
  final String created_time;

  Report(
    this.id, 
    this.sender_id, 
    this.sender_name, 
    this.receiver_id,
    this.type,
    this.optional_val,
    this.created_time);

  Report.fromJson(Map<String, dynamic> json)
      : id = json['report_id'],
        sender_id = json['sender_id'],
        sender_name = json['sender_name'],
        receiver_id = json['receiver_id'],
        type = json['type'],
        optional_val = json['optional_val'],
        created_time = json['created_time'];
}

class Donate {
  final String id;
  final String contribute_id;
  final String donated_user_id;
  final String donated_member_name;
  final String donated_member_phone;
  final String donated_time;
  final String donated_amount;

  Donate(
      this.id,
      this.contribute_id,
      this.donated_user_id,
      this.donated_member_name,
      this.donated_member_phone,
      this.donated_time,
      this.donated_amount);

  Donate.fromJson(Map<String, dynamic> json)
      : id = json['donate_id'],
        contribute_id = json['contribute_id'],
        donated_user_id = json['donated_user_id'],
        donated_member_name = json['donated_member_name'],
        donated_member_phone = json['donated_member_phone'],
        donated_time = json['donated_time'],
        donated_amount = json['donated_amount'];
}

enum ReportType {
  member_add,
  contribute_creat,
  contribute_join,
  contribute_end
}

List<Member> members;
List<Group> groups;
List<Contribute> contributes;
List<Report> reports;
List<Donate> donates;
List<PhoneNumber> phoneNumbers;

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

class PhoneNumber {
  final int id;
  final String number;
  PhoneNumber(this.id, this.number);
}

Function textFieldNull() {}
