import 'package:flutter/material.dart';
import 'package:raize/DetailWidget.dart';

class ParticipantDetailWidget extends StatefulWidget
{

    @override
    _ParticioantState createState() => _ParticioantState();


}

class _ParticioantState extends State<ParticipantDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Events Detail"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new DetailWidget()

            ],
          ),
        )
    );
  }
}
