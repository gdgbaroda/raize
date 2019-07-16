import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raize/models/EventModel.dart';
import 'package:http/http.dart' as http;
import 'package:raize/EventDetailsWidget.dart';

import 'models/EventListModel.dart';

class EventListWidget extends StatefulWidget {
  static String tag = 'eventList-screen';

  @override
  _EventListWidget createState() => new _EventListWidget();
}

class _EventListWidget extends State<EventListWidget> {
 // List<EventModel> _items = new List();
  List<EventListDummyModel> _items = new List();


  //add an item to the list
  void _addItem(item) {
    setState(() {
      _items.add(EventListDummyModel.fromJson(item));
    });
  }

  @override
  void initState() {
    super.initState();
    //this will be called at the start of the activity,it will add dummy data to our list
    for (var i = 0; i < 15; i++) {
      _addItem({
        "id": 1,
        "banner": "https://dart-code.gallerycdn.vsassets.io/extensions/dart-code/flutter/3.2.0/1561724669242/Microsoft.VisualStudio.Services.Icons.Default",
        "title": "Learning flutter: Rx dart",
        "description": "this event will be about learning how to implement rx in dart project",
        "hosts": [
          {
            "fullname": "kushal dave",
            "email": "kushaldave2015@gmail.com"
          },
          {
            "fullname": "kushal",
            "email": "kushaldave2011@gmail.com"
          }
        ],
        "attendees": [
          {
            "fullname": "Jane Doe",
            "email": "jane.doe@gmail.com",
            "state": [
              {
                "value": "Invited",
                "updatedOn": "01/01/2019"
              },
              {
                "value": "Invited",
                "updatedOn": "01/01/2019"
              }
            ]
          }
        ],
        "venue": {
          "address": "xya",
          "city": "vadodara",
          "state": "gujarat",
          "country": "INDIA",
          "pinCode": 123456
        },
        "duration": {
          "start": {
            "date": "01/01/2019",
            "time": "10:00"
          },
          "end": {
            "date": "01/01/2019",
            "time": "12:00"
          }
        },
        "isActive": true
      });
    }
  }


  //creates view for each item in listview
  Widget _createEventItem(BuildContext context, EventListDummyModel eventModel) {
    return new GestureDetector( //listens for on tap
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            //builder: (context) => EventDetailsWidget(eventModel: eventModel),
            builder: (context) => new EventDetailsWidget()
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Padding(
              padding: new EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  new Image.network("test",//eventModel.events[1].title,
                      height: 80.0, width: 80.0, fit: BoxFit.fitHeight),
                  Expanded(
                      child: Container(
                        height: 80.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        /*child: _createEventItemDescriptionSection(
                            context, eventModel.events[1]),*/
                      )),
                ],
              )),

          new Divider(height: 15.0, color: Colors.black,),

        ],
      ),
    );
  }

  Widget _createEventItemDescriptionSection(BuildContext context,
      EventModel eventModel) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          eventModel.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          eventModel.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(600.0),
        child: const Text(''),
      ),
      body: new Container(
        padding:
        new EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
        child: new Column(
          children: <Widget>[
            new Expanded(
              /*child: Card(
                child: ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _createEventItem(context, _items[index]);
                  },
                ),
              ),
            ),*/

            child: new FutureBuilder(
                future: DefaultAssetBundle
                    .of(context)
                    .loadString('assets/raize-dummy-events-list.json'),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var new_data = json.decode(snapshot.data.toString());

                  return new ListView.builder(
                    // Build the ListView
                    padding: new EdgeInsets.all(8.0),
                    itemBuilder: (BuildContext context, int index) {

                      return  _createEventItem(context, _items[index]);
                    },
                    itemCount: new_data == null ? 0 : new_data.length,
                  );
                })
            )
          ],
        ),
      ),
    );
  }
}

