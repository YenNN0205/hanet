class HanetPlace {
  int? id;
  int? userID;
  String? name;
  String? address;
  String? permission;
  bool? linked;

  HanetPlace(
      {this.id,
      this.userID,
      this.name,
      this.address,
      this.permission,
      this.linked});

  HanetPlace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    name = json['name'];
    address = json['address'];
    permission = json['permission'];
    linked = json['linked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['address'] = this.address;
    data['permission'] = this.permission;
    data['linked'] = this.linked;
    return data;
  }
}
