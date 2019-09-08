import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raize/api/api_manager.dart';
import 'package:raize/models/event_model.dart';
import 'package:raize/event_details_widget.dart';
import 'package:raize/shared_pref.dart';

import 'models/event_list_item_model.dart';
import 'models/event_list_model.dart';

class EventListWidget extends StatefulWidget {
  static String tag = 'eventList-screen';

  @override
  _EventListWidget createState() => new _EventListWidget();
}

class _EventListWidget extends State<EventListWidget> {
  EventListModel _items;


  //add an item to the list
  void _addItem(item) {
    if(item!=null){
      setState(() {
        _items = EventListModel.fromJson(item);
      });
    }

  }

  @override
  void initState() {
    super.initState();
    //this will be called at the start of the activity,it will add dummy data to our list

    getDataFromApi() async {
      var accessToken = await SharedPref.getAccessToken();
      var temp = await APIManager.getEventsList(accessToken);
      _addItem( temp);
    }

    getDataFromApi();

  }
  //creates view for each item in listview
  Widget _createEventsParentItem(BuildContext context, EventListItemModel eventList) {
    return new  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Padding(
                padding: const EdgeInsets.fromLTRB(8,0,0,0),
                child: Text(
                  eventList.title,
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,)
                ),
                  ListView.builder(
                      padding: new EdgeInsets.all(8.0),
                      shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: eventList.events.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _createEventItem(context, eventList.events[index],eventList.thumbnail);
                      },
                    ),


//          new Divider(height: 15.0,color: Colors.black,),

        ],
      );
  }

  //creates view for each item in listview
  Widget _createEventItem(BuildContext context, EventModel eventModel, String thumbnail) {
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
          Card(
            child: Padding(
          padding: new EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    new Image.network(thumbnail,
                        height: 80.0, width: 80.0, fit: BoxFit.fitHeight),
                    Expanded(
                        child: Container(
                          height: 80.0,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: _createEventItemDescriptionSection(context, eventModel),
                        )),
                  ],
                )
              )),

//          new Divider(height: 15.0,color: Colors.black,),

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
                  itemCount: _items.groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    EventListItemModel eventListModel = _items.groups[index];
                    return _createEventsParentItem(context, eventListModel);
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}

