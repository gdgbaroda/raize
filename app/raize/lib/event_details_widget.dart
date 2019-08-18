import 'package:flutter/material.dart';
import 'package:raize/detail_widget.dart';
import 'package:raize/models/event_model.dart';

class EventDetailsWidget extends StatefulWidget {
  static String tag = 'eventList-screen';

  // Declare a field that holds the Todo.
  final EventModel eventModel;

  // In the constructor, require a Todo.
  EventDetailsWidget({@required  this.eventModel}) ;

  @override
  _EventState createState() => _EventState(eventModel);
}

class _EventState extends State<EventDetailsWidget> {
  EventModel eventModel;
  _EventState(EventModel eventModel){
    this.eventModel = eventModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(eventModel.title),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DetailWidget(eventModel: eventModel)
                      ]),
                )
              ]),
        ));

  }
}
