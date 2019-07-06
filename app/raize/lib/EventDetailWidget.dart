import 'package:flutter/material.dart';
import 'package:raize/DetailWidget.dart';

class EventDetailWidget extends StatefulWidget
{
  static String tag = 'eventList-screen';

    @override
    _EventState createState() => _EventState();


}

class _EventState extends State<EventDetailWidget> {
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
