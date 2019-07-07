class EventVenueModel {
  String address;
  String city;
  String state;
  String country;
  int pinCode;

  EventVenueModel({this.address, this.city, this.state, this.country, this.pinCode});

  EventVenueModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pinCode'] = this.pinCode;
    return data;
  }
}
