import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:raize/utility/urls.dart';

class APIManager {
  static Future<bool> getAccessToken(String code) async {
    await http.get(URLs.URL_CALLBACK + "/?code=" + code).then((response) {
      var convertedData = jsonDecode(response.body);
      //print("response $convertedData");
//      var token = convertedData["access_token"];
//      print("access_token $token");

      return true;
    });
  }
}
