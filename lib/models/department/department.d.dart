class HanetDepartment {
  String? createdAt;
  String? desc;
  int? enable;
  int? id;
  String? name;
  String? numEmployee;
  String? placeId;
  int? status;
  String? updatedAt;

  HanetDepartment(
      {this.createdAt,
      this.desc,
      this.enable,
      this.id,
      this.name,
      this.numEmployee,
      this.placeId,
      this.status,
      this.updatedAt});

  HanetDepartment.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    desc = json['desc'];
    enable = json['enable'];
    id = json['id'];
    name = json['name'];
    numEmployee = json['numEmployee'];
    placeId = json['placeId'];
    status = json['status'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['desc'] = this.desc;
    data['enable'] = this.enable;
    data['id'] = this.id;
    data['name'] = this.name;
    data['numEmployee'] = this.numEmployee;
    data['placeId'] = this.placeId;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
