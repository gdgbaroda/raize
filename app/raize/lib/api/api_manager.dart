import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:raize/shared_pref.dart';
import 'package:raize/utility/urls.dart';

class APIManager {
  static Future<bool> getAccessToken(String code) async {
    return await http
        .get(URLs.URL_CALLBACK_TOKEN + "/?code=" + code)
        .then((response) {
      if (response != null) {
        var convertedData = jsonDecode(response.body);
        if (convertedData != null) {
          print("response $convertedData");
          SharedPref.setAccessToken(convertedData["access_token"]);
          SharedPref.setRefreshToken(convertedData["refresh_token"]);
          SharedPref.setTokenType(convertedData["token_type"]);
          SharedPref.setTokenExpiryTime(convertedData["expires_in"]);

          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    });
  }

  static Future<bool> validateUser(String code) async {
    return await http
        .get(URLs.URL_VERIFY_QR_CODE + code)
        .then((response) {
      if (response != null) {
        var convertedData = jsonDecode(response.body);
        if (convertedData != null) {
          print("response $convertedData");
          return convertedData["status"];
        } else {
          return false;
        }
      } else {
        return false;
      }
    });
  }
}
