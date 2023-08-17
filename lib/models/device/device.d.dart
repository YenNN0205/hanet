import 'package:hanet/models/respond/respond.d.dart';

class HanetDevice {
  String? deviceID;
  String? deviceName;
  String? placeName;
  String? address;
  int? placeID;
  int? type;
  String? timeZone;

  HanetDevice(
      {this.deviceID,
      this.deviceName,
      this.placeName,
      this.address,
      this.placeID,
      this.type,
      this.timeZone});

  HanetDevice.fromJson(Map<String, dynamic> json) {
    deviceID = json['deviceID'];
    deviceName = json['deviceName'];
    placeName = json['placeName'];
    address = json['address'];
    placeID = json['placeID'];
    type = json['type'];
    timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceID'] = this.deviceID;
    data['deviceName'] = this.deviceName;
    data['placeName'] = this.placeName;
    data['address'] = this.address;
    data['placeID'] = this.placeID;
    data['type'] = this.type;
    data['timeZone'] = this.timeZone;
    return data;
  }
}
