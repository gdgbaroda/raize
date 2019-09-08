import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raize/models/event_model.dart';
import 'package:raize/event_details_widget.dart';

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
    setState(() {
      _items = EventListModel.fromJson(item);
    });
  }

  @override
  void initState() {
    super.initState();
    //this will be called at the start of the activity,it will add dummy data to our list

    _addItem({
      "groups": [
        {
          "id": 18190208,
          "title": "Google Developers Group, Baroda : GDG Baroda",
          "source": "meetup",
          "thumbnail": "https://secure.meetupstatic.com/photos/event/6/2/e/d/thumb_480865325.jpeg",
          "location": "Vadodara, India",
          "events": [
            {
              "id": "261067798",
              "title": "GDG DevFest Baroda 2019 & Kotlin/Everywhere Baroda 2019",
              "host": false,
              "description": "<p>TICKETS TO THE EVENT ARE SOLD OUT!!</p> <p>GDG DevFest Baroda 2019 brings together people who shape the future of Android, Web and Cloud technologies for a day of sessions, workshops and networking.</p> <p>Described by many as 'The best DevFest in India', our team creates DevFest to be the best place for inspiration and experience sharing.</p> <p>*** GDG DevFest Baroda 2019 official website: <a href=\"https://devfest.gdgbaroda.com\" class=\"linkified\">https://devfest.gdgbaroda.com</a> ***</p> <p>GDG Baroda is also bringing Kotlin/Everywhere global event series with DevFest where experts will be participating to show us what we can do with Kotlin. This event will be part of the themes that will be exhibited within the DevFest Baroda 2019 and that will have renowned speakers.</p> <p>Just like every year, Baroda invites Googlers, dignitaries, expert speakers, VIPs and organizers from other communities, yet most importantly, diverse &amp; enthusiastic audience.</p> <p>Witness exceptional speakers invited from across the world, audience from across India &amp; executives from local startups &amp; global enterprises. We thrive to provide the best platform in form of opportunities for everyone! Expect jam packed action content, fun activities, delicious chit chat over food, networking, future growth &amp; much more.</p> <p>See you at the DevFest!</p> <p>#GDGBaroda #WTMBaroda #DevFestBaroda #DevFest19 #IndiaDevFest19</p> ",
              "venue": {
                "id": 25942147,
                "name": "Hotel Sayaji",
                "lat": 22.30580711364746,
                "lon": 73.18620300292969,
                "repinned": false,
                "address_1": "Near Bhimnath Bridge",
                "address_2": "Jetalpur Road, Sayajigunj",
                "city": "Vadodara",
                "country": "IN",
                "localized_country_name": "India"
              },
              "duration": 118800000
            }
          ]
        },
        {
          "id": 30906470,
          "title": "GDG Cloud Ahmedabad",
          "source": "meetup",
          "thumbnail": "",
          "location": "Ahmedabad, India",
          "events": [
            {
              "id": "264521008",
              "title": "TensorFlow All-Around - Ahmedabad",
              "host": false,
              "description": "<p>Join us for the TensorFlow All-Around Ahmedabad event and get hands-on experience with TensorFlow together!</p> <p>After this event, you can keep developing your skills at home by completing all the recommended codelab, tutorials, and videos.</p> <p>Bring a laptop and charger (PC, Mac or Chromebook)! For the best experience, make sure your laptop has installed Python dev environment, your favorite editor (e.g., Visual Studio Code), or latest browser for using online codelab environment. Don’t forget your charger.</p> <p>Registration Form: shorturl.at/wxFQU</p> ",
              "venue": {
                "id": 26608955,
                "name": "The Address ",
                "lat": 23.003267288208008,
                "lon": 72.50147247314453,
                "repinned": true,
                "address_1": "West Gate, 22nd Floor, YMCA Club Road, Near YMCA Club, SG Highway, 18th floor, 22nd floor,",
                "city": "Ahmedabad",
                "country": "in",
                "localized_country_name": "India"
              },
              "duration": 10800000
            }
          ]
        },
        {
          "id": 29946762,
          "title": "Google Developer Group : GDG Surat",
          "source": "meetup",
          "thumbnail": "https://secure.meetupstatic.com/photos/event/b/c/9/0/thumb_482148272.jpeg",
          "location": "Surat, India",
          "events": [
            {
              "id": "262668022",
              "title": "GDG Surat DevFest 2019",
              "host": false,
              "description": "<p>GDG DevFest 2019 is our annual all-day developer conference that offers speaker sessions across multiple product areas, code labs, hackathon and more!</p> <p>This year we are coming up with exciting technologies that may help you in broader aspects of your professional life. It's a Tech Jamming event which helps you as an attendee to learn new things, making new connections, Exploring yourself and of course enjoy! :)</p> <p>Register Your Self: <a href=\"https://allevents.in/surat/gdg-devfest-surat-2019/80003024233175\" class=\"linkified\">https://allevents.in/surat/gdg-devfest-surat-2019/80003024233175</a></p> <p>We invite you to this global series of DevFest 2019 by Google Developer Group which is happening in your own town.</p> <p>More details to be updated soon, thanks for dropping by!</p> ",
              "venue": {
                "id": 26604711,
                "name": "Shree Swami Atmanand Saraswati Institute of Technology",
                "lat": 21.222803115844727,
                "lon": 72.87886810302734,
                "repinned": true,
                "address_1": "Varachha Main Rd",
                "city": "Surat",
                "country": "in",
                "localized_country_name": "India"
              },
              "duration": 32400000
            }
          ]
        }
      ]
    }
    );
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

