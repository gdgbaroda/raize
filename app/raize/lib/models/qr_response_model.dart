import 'package:raize/models/attendee_state_model.dart';

class QRResponseModel {
  bool status;
  String reason = "";

  QRResponseModel({this.status, this.reason});



  QRResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['reason'] != null) {
      reason = json['reason'];

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (data['reason'] != null) {
      data['reason'] = this.reason;
    }
    return data;
  }
}