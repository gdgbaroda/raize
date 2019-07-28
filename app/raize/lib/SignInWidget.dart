import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raize/EventDetailsWidget.dart';

class SignInWidget extends StatefulWidget {
  static String tag = 'signin-screen';
  @override
  _SignInWidget createState() => _SignInWidget();
}

class _SignInWidget extends State<SignInWidget> {
  @override
  void initState() {
    super.initState();

    /*Timer(Duration(seconds: 2), () => Navigator.push(
      context,
      MaterialPageRoute(
       // builder: (context) => new EventDetailWidget())
    ));*/
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
                child: Container(//todo add ui here
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sign In Screen",
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