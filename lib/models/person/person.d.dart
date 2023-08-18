class HanetPerson {
  String? aliasID;
  int? sex;
  String? name;
  String? id;
  String? avatar;
  String? title;
  int? type;
  int? age;

  HanetPerson(
      {this.aliasID,
      this.sex,
      this.name,
      this.id,
      this.avatar,
      this.title,
      this.type,
      this.age});

  HanetPerson.fromJson(Map<String, dynamic> json) {
    aliasID = json['aliasID'];
    sex = json['sex'];
    name = json['name'];
    id = json['id'];
    avatar = json['avatar'];
    title = json['title'];
    type = json['type'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aliasID'] = this.aliasID;
    data['sex'] = this.sex;
    data['name'] = this.name;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['title'] = this.title;
    data['type'] = this.type;
    data['age'] = this.age;
    return data;
  }
}
