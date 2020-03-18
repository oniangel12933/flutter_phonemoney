import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> postApiCall(Map<String, String> params, String url) async {
  
    Map<String, String> headerParams = {
      "Content-Type": 'application/json',
      "Accept": 'application/json',
    };

    final response = await http.post(Uri.encodeFull(url),
          headers: headerParams,
          body: json.encode(params));

    return json.decode(response.body);
}