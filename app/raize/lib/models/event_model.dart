import 'package:raize/models/attendee_model.dart';
import 'package:raize/models/event_duration_model.dart';
import 'package:raize/models/event_venue_model.dart';
import 'package:raize/models/host_model.dart';

class EventModel {
  String id;
  String banner;
  String title;
  String description;
  List<HostModel> hosts;
  List<AttendeeModel> attendees;
  EventVenueModel venue;
  EventDurationModel duration;
  bool isActive;

  EventModel(
      {this.id,
        this.banner,
        this.title,
        this.description,
        this.hosts,
        this.attendees,
        this.venue,
        this.duration,
        this.isActive});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    title = json['title'];
    description = json['description'];
    if (json['hosts'] != null) {
      hosts = new List<HostModel>();
      json['hosts'].forEach((v) {
        hosts.add(new HostModel.fromJson(v));
      });
    }
    if (json['attendees'] != null) {
      attendees = new List<AttendeeModel>();
      json['attendees'].forEach((v) {
        attendees.add(new AttendeeModel.fromJson(v));
      });
    }
    venue = json['venue'] != null ? new EventVenueModel.fromJson(json['venue']) : null;
    duration = json['duration'] != null
        ? new EventDurationModel.fromJson(json['duration'])
        : null;
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.hosts != null) {
      data['hosts'] = this.hosts.map((v) => v.toJson()).toList();
    }
    if (this.attendees != null) {
      data['attendees'] = this.attendees.map((v) => v.toJson()).toList();
    }
    if (this.venue != null) {
      data['venue'] = this.venue.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    data['isActive'] = this.isActive;
    return data;
  }
}
