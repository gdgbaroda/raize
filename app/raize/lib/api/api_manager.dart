import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:raize/models/event_list_model.dart';
import 'package:raize/shared_pref.dart';
import 'package:raize/utility/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<EventListModel> getEvents() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("access_token") ?? "";

    // print("Access token $token");

    return await http.get(URLs.URL_EVENTS, headers: { HttpHeaders.authorizationHeader: "Bearer " + token })
          .then((response) 
          {
                if(response != null)
                {
                    var convertedData = jsonDecode(response.body);

                    if(convertedData != null)
                    {
                        // print('Events $convertedData');
                        return EventListModel.fromJson(convertedData);

                    }

                  return null;
                }

                return null;
          });

  }
}
