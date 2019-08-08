import 'EventModel.dart';
import 'Location.dart';

class EventListModel {
  String id;
  String title;
  String source;
  Location location;
  List<EventModel> events;
  String lastUpdatedOn;
  bool isactive;

  EventListModel(
      {this.id,
        this.title,
        this.source,
        this.location,
        this.events,
        this.lastUpdatedOn,
        this.isactive});

  EventListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    source = json['source'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['events'] != null) {
      events = new List<EventModel>();
      json['events'].forEach((v) {
        events.add(new EventModel.fromJson(v));
      });
    }
    lastUpdatedOn = json['lastUpdatedOn'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['source'] = this.source;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    data['lastUpdatedOn'] = this.lastUpdatedOn;
    data['isactive'] = this.isactive;
    return data;
  }

}
