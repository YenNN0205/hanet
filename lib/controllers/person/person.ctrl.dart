import 'package:get/get.dart';
import 'package:hanet/controllers/api/api.ctrl.dart';
import 'package:hanet/controllers/config/env.ctrl.dart';
import 'package:hanet/models/person/person.d.dart';
import 'package:hanet/models/respond/respond.d.dart';

class PersonController extends GetxController {
  Future<List<HanetPerson>> getPeopleByPlace(String placeId) async {
    List<HanetPerson> people = [];
    final respond = await ApiHanlder.post('/person/getListByPlace', body: {
      "token": EnvironmentController.ACCESS_TOKEN,
      "placeID": placeId,
      "type": 0,
    });

    try {
      final data = HanetRespond.fromJson(respond.data);
      for (var person in data.data) {
        people.add(HanetPerson.fromJson(person));
      }
    } catch (e) {}

    return people;
  }
}
