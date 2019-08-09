import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raize/models/EventModel.dart';
import 'package:raize/EventDetailsWidget.dart';

import 'models/EventListModel.dart';

class EventListWidget extends StatefulWidget {
  static String tag = 'eventList-screen';

  @override
  _EventListWidget createState() => new _EventListWidget();
}

class _EventListWidget extends State<EventListWidget> {
  List<EventListModel> _items = new List();


  //add an item to the list
  void _addItem(item) {
    setState(() {
      _items.add(EventListModel.fromJson(item));
    });
  }

  @override
  void initState() {
    super.initState();
    //this will be called at the start of the activity,it will add dummy data to our list
    for (var i =0;i<3;i++){

      _addItem({
        "id":"4253ff73-99c2-4cfa-b785-7cbb8c4c0a8f",
        "title":"GDG Baroda",
        "source":"meetup.com",
        "location":
        {
          "city":"Vadodara",
          "country":"India"
        },
        "events":
        [
          {
            "id": "4253ff73-99c2-4cfa-b785-7cbb8c4c0a8f",
            "banner": "https://dart-code.gallerycdn.vsassets.io/extensions/dart-code/flutter/3.2.0/1561724669242/Microsoft.VisualStudio.Services.Icons.Default",
            "title":"Learning flutter: Rx dart",
            "description":"this event will be about learning how to implement rx in dart project",
            "hosts":[
              {
                "fullname": "kushal dave",
                "email":"kushaldave2015@gmail.com"
              },
              {
                "fullname": "kushal",
                "email":"kushaldave2011@gmail.com"
              }
            ],
            "attendees":
            [
              {
                "fullname": "Jane Doe",
                "email":"jane.doe@gmail.com",
                "state":
                [
                  {
                    "value":"Invited",
                    "updatedOn":"01/01/2019"
                  }
                ]
              }
            ],
            "venue":
            {
              "address":"Sayaji The Hotel",
              "city": "Vadodara",
              "state":"Gujarat",
              "country":"INDIA",
              "pinCode":390001
            },
            "duration":{
              "start":{
                "date":"01/01/2019",
                "time":"10:00"
              },
              "end":{
                "date":"01/01/2019",
                "time":"12:00"
              }
            },
            "isActive": true
          },
          {
            "id": "4253ff73-99c2-4cfa-b785-7cbb8c4c0a50",
            "banner": "https://dart-code.gallerycdn.vsassets.io/extensions/dart-code/flutter/3.2.0/1561724669242/Microsoft.VisualStudio.Services.Icons.Default",
            "title":"Flutter with Visual Code",
            "description":"Action packed demo driven session for using Flutter with Microsoft Visual Code editor",
            "hosts":
            [
              {
                "fullname": "Prachi Durge",
                "email":"prachidurge@gmail.com"
              }
            ],
            "attendees":
            [
              {
                "fullname": "Jane Doe",
                "email":"jane.doe@gmail.com",
                "state":
                [
                  {
                    "value":"Invited",
                    "updatedOn":"01/01/2019"
                  }
                ]
              }
            ],
            "venue":
            {
              "address":"Arnomaly Labs",
              "city": "Vadodara",
              "state":"Gujarat",
              "country":"INDIA",
              "pinCode":390020
            },
            "duration":{
              "start":{
                "date":"01/02/2019",
                "time":"10:00"
              },
              "end":{
                "date":"01/02/2019",
                "time":"12:00"
              }
            },
            "isActive": true
          },
          {
            "id": "4253ff73-99c2-4cfa-b785-7cbb8c4c0a50",
            "banner": "https://dart-code.gallerycdn.vsassets.io/extensions/dart-code/flutter/3.2.0/1561724669242/Microsoft.VisualStudio.Services.Icons.Default",
            "title":"Flutter with Visual Code",
            "description":"Action packed demo driven session for using Flutter with Microsoft Visual Code editor",
            "hosts":
            [
              {
                "fullname": "Prachi Durge",
                "email":"prachidurge@gmail.com"
              }
            ],
            "attendees":
            [
              {
                "fullname": "Jane Doe",
                "email":"jane.doe@gmail.com",
                "state":
                [
                  {
                    "value":"Invited",
                    "updatedOn":"01/01/2019"
                  }
                ]
              }
            ],
            "venue":
            {
              "address":"Arnomaly Labs",
              "city": "Vadodara",
              "state":"Gujarat",
              "country":"INDIA",
              "pinCode":390020
            },
            "duration":{
              "start":{
                "date":"01/02/2019",
                "time":"10:00"
              },
              "end":{
                "date":"01/02/2019",
                "time":"12:00"
              }
            },
            "isActive": true
          }

        ],
        "lastUpdatedOn":"14/07/2019 12:35:54",
        "isactive":true
      });
    }
  }

  //creates view for each item in listview
  Widget _createEventsParentItem(BuildContext context, EventListModel eventList) {
    return new  Column(
                children: <Widget>[
                  Text(eventList.title),
                  ListView.builder(
                      padding: new EdgeInsets.all(8.0),
                      shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: eventList.events.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _createEventItem(context, eventList.events[index]);
                      },
                    ),


          new Divider(height: 15.0,color: Colors.black,),

        ],
      );
  }

  //creates view for each item in listview
  Widget _createEventItem(BuildContext context, EventModel eventModel) {
    return new GestureDetector( //listens for on tap
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
           builder: (context) => EventDetailsWidget(eventModel:eventModel),
              //builder: (context) => new EventDetailsWidget()
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Padding(
              padding: new EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  new Image.network(eventModel.banner,
                      height: 80.0, width: 80.0, fit: BoxFit.fitHeight),
                  Expanded(
                      child: Container(
                        height: 80.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: _createEventItemDescriptionSection(context, eventModel),
                      )),
                ],
              )),

          new Divider(height: 15.0,color: Colors.black,),

        ],
      ),
    );
  }

  Widget _createEventItemDescriptionSection(BuildContext context, EventModel eventModel) {
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
                child: ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _createEventsParentItem(context, _items[index]);
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}

