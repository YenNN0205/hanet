import 'package:hanet/models/person/person.d.dart';

class Attendance {
  HanetPerson? person;
  DateTime? checkIn;
  DateTime? checkOut;
  Attendance({this.person, this.checkIn, this.checkOut});
  Map<String, dynamic> toJson() {
    return {
      "person": person?.toJson(),
      "checkIn": checkIn,
      "checkOut": checkOut,
    };
  }
}
