import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';

Future<Map<String, dynamic>> postApiCall(
    Map<String, String> params, String url) async {
  Map<String, String> headerParams = {
    "Content-Type": 'application/json',
    "Accept": 'application/json',
  };

  final response = await http.post(Uri.encodeFull(url),
      headers: headerParams, body: json.encode(params));

  return json.decode(response.body);
}

String getTime(String time) {
  DateFormat format1 = DateFormat("yyyy-MM-dd-HH-mm");
  DateTime dateTime = format1.parse(time);
  DateFormat format2 = DateFormat("MMM dd");
  return format2.format(dateTime);
}
