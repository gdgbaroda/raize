import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raize/SignInWidget.dart';

class SplashWidget extends StatefulWidget {
  static String tag = 'splash-screen';
  @override
  _SplashWidget createState() => _SplashWidget();
}

class _SplashWidget extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.push(
      context,
      MaterialPageRoute(
            builder: (context) => SignInWidget(),//goes to the next page
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
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Splash",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}