import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raize/EventWidget.dart';
import 'package:raize/Model/EventModel.dart';

class SignInWidget extends StatefulWidget {
  static String tag = 'signin-screen';
  @override
  _SignInWidget createState() => _SignInWidget();
}

class _SignInWidget extends State<SignInWidget> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => new EventWidget(event:
      [
      new EventModel('Tech event ','assets/person.jpeg',"26/June 1 Am"),
      new EventModel('Android Tech talk ','assets/person.jpeg',"25/November 1 Am"),
      new EventModel('Fly With Flutter ','assets/person.jpeg',"1 December 1 Am"),
      ],),//goes to the next page
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