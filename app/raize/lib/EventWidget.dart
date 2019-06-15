import 'package:flutter/material.dart';
import 'package:raize/Model/EventModel.dart';

class EventWidget extends StatefulWidget
{
  static String tag = 'eventList-screen';

  EventWidget({Key key, this.event}) :super(key: key);
    List<EventModel> event;
    @override
    _EventListState createState() => _EventListState();


}

class _EventListState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Events"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(child: new ListView(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: widget.event.map((EventModel event) {
                  return new EventItemList(event);
                }).toList(),
              )),


            ],
          ),
        )
    );
  }
}
class EventItemList extends StatefulWidget{
  final EventModel product;
  EventItemList(EventModel product)
      : product = product,
        super(key: new ObjectKey(product));
  @override
  ShoppingItemState createState() {
    return new ShoppingItemState(product);
  }
}
class ShoppingItemState extends State<EventItemList> {
  final EventModel product;
  ShoppingItemState(this.product);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap:null,
        leading: new CircleAvatar(
          backgroundColor: Colors.blue,
          child: new Image(image: new AssetImage(product.eventUrl)),
        ),
        title: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(product.eventName),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Text(product.eventTime),
            )
          ],
        )
    );
  }
}
