import 'package:raize/models/attendee_model.dart';
import 'package:raize/models/event_duration_model.dart';
import 'package:raize/models/event_venue_model.dart';
import 'package:raize/models/host_model.dart';

class EventModel {
  String id;
  String title;
  String description;
  bool host;
  EventVenueModel venue;
//  EventDurationModel EventDurationModelduration;

  EventModel(
      {this.id,
        this.title,
        this.description,
        this.host,
        this.venue
//        this.duration
      });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];

      host = json['hosts'];

    venue = json['venue'] != null ? new EventVenueModel.fromJson(json['venue']) : null;
//    duration = json['duration'] != null
//        ? new EventDurationModel.fromJson(json['duration'])
//        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
      data['hosts'] = this.host;

    if (this.venue != null) {
      data['venue'] = this.venue.toJson();
    }
//    if (this.duration != null) {
//      data['duration'] = this.duration.toJson();
//    }
    return data;
  }
}
