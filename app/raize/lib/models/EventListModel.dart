import 'EventModel.dart';
import 'Location.dart';

class EventListDummyModel {
  int id;
  String title;
  String source;
  Location location;
  List<EventModel> events;

  EventListDummyModel(
      {this.id, this.title, this.source, this.location, this.events});

  EventListDummyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    source = json['source'];
    location = json['location'];
    events = json['events'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['source'] = this.source;
    data['location'] = this.location;
    data['events'] = this.events;

    return data;
  }

}
