class HanetPerson {
  String? personID;
  String? name;
  int? placeID;
  String? title;
  int? type;
  String? avatar;
  int? sex;
  int? age;
  String? aliasID;
  String? phone;
  int? enable;
  int? departmentID;
  String? dob;

  HanetPerson(
      {this.personID,
      this.name,
      this.placeID,
      this.title,
      this.type,
      this.avatar,
      this.sex,
      this.age,
      this.aliasID,
      this.phone,
      this.enable,
      this.departmentID,
      this.dob});

  HanetPerson.fromJson(Map<String, dynamic> json) {
    personID = json['personID'];
    name = json['name'];
    placeID = json['placeID'];
    title = json['title'];
    type = json['type'];
    avatar = json['avatar'];
    sex = json['sex'];
    age = json['age'];
    aliasID = json['aliasID'];
    phone = json['phone'];
    enable = json['enable'];
    departmentID = json['departmentID'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personID'] = this.personID;
    data['name'] = this.name;
    data['placeID'] = this.placeID;
    data['title'] = this.title;
    data['type'] = this.type;
    data['avatar'] = this.avatar;
    data['sex'] = this.sex;
    data['age'] = this.age;
    data['aliasID'] = this.aliasID;
    data['phone'] = this.phone;
    data['enable'] = this.enable;
    data['departmentID'] = this.departmentID;
    data['dob'] = this.dob;
    return data;
  }
}
