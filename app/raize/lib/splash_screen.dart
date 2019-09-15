import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raize/sign_in.dart';
import 'package:raize/shared_pref.dart';
import 'package:raize/event_list_screen.dart';

class SplashWidget extends StatefulWidget {
  static String tag = 'splash-screen';

  @override
  _SplashWidget createState() => _SplashWidget();
}

class _SplashWidget extends State<SplashWidget> {
  @override
  initState() {
    super.initState();
//    var temp = await SharedPref.getAccessToken();
    var accessToken;
    SharedPref.getAccessToken().then(accessToken);
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: accessToken == null || accessToken ==""
                      ? (context) => SignInWidget()
                      : (context) => EventListWidget() //goes to the next page
                  ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Image.asset('images/icon.png')
                   
                       // child: Icon(
                       //  Icons.apps,
                       // color: Colors.blueAccent,
                       //size: 50.0,
                       // ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
