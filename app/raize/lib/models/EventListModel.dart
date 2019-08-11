import 'EventListItemModel.dart';

class EventListModel {
  List<EventListItemModel> events;
  EventListModel({
    this.events
});
  EventListModel.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = new List<EventListItemModel>();
      json['events'].forEach((v) {
        events.add(new EventListItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}