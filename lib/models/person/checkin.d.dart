class HanetCheckIn {
  String? personName;
  String? personID;
  String? aliasID;
  String? avatar;
  String? date;
  int? placeID;
  String? place;
  String? title;
  int? type;
  String? deviceID;
  String? deviceName;
  int? checkinTime;

  HanetCheckIn(
      {this.personName,
      this.personID,
      this.aliasID,
      this.avatar,
      this.date,
      this.placeID,
      this.place,
      this.title,
      this.type,
      this.deviceID,
      this.deviceName,
      this.checkinTime});

  HanetCheckIn.fromJson(Map<String, dynamic> json) {
    personName = json['personName'];
    personID = json['personID'];
    aliasID = json['aliasID'];
    avatar = json['avatar'];
    date = json['date'];
    placeID = json['placeID'];
    place = json['place'];
    title = json['title'];
    type = json['type'];
    deviceID = json['deviceID'];
    deviceName = json['deviceName'];
    checkinTime = json['checkinTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personName'] = this.personName;
    data['personID'] = this.personID;
    data['aliasID'] = this.aliasID;
    data['avatar'] = this.avatar;
    data['date'] = this.date;
    data['placeID'] = this.placeID;
    data['place'] = this.place;
    data['title'] = this.title;
    data['type'] = this.type;
    data['deviceID'] = this.deviceID;
    data['deviceName'] = this.deviceName;
    data['checkinTime'] = this.checkinTime;
    return data;
  }
}
