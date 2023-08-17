class HanetRespond {
  int? statusCode;
  int? returnCode;
  String? returnMessage;
  dynamic data;

  HanetRespond(
      {this.statusCode, this.returnCode, this.returnMessage, this.data});

  HanetRespond.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    returnCode = json['returnCode'];
    returnMessage = json['returnMessage'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['returnCode'] = this.returnCode;
    data['returnMessage'] = this.returnMessage;

    data['data'] = this.data;

    return data;
  }
}
