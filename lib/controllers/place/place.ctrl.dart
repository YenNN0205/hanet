// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:hanet/controllers/api/api.ctrl.dart';
import 'package:hanet/controllers/config/env.ctrl.dart';
import 'package:hanet/models/department/department.d.dart';
import 'package:hanet/models/place/place.d.dart';
import 'package:hanet/models/respond/respond.d.dart';

class PlaceController extends GetxController {
  // stored data
  RxList<HanetPlace> places = <HanetPlace>[].obs;
  Map<String, RxList<HanetDepartment>> departmentsMap =
      Map(); // map placeID with department list

  // place config
  static const String PLACE_PATH = "/place";

  // department config
  static const String DEPARTMENT_PATH = "/department";

  Future<List<HanetPlace>> getAllPlaces() async {
    List<HanetPlace> places = [];
    var respond = await ApiHanlder.post("$PLACE_PATH/getPlaces", body: {
      "token": EnvironmentController.ACCESS_TOKEN,
    });
    try {
      if (respond.statusCode == 200) {
        HanetRespond respondData = HanetRespond.fromJson(respond.data);
        for (var place in respondData.data) {
          places.add(HanetPlace.fromJson(place));
        }
      }
    } catch (e) {
      print(e);
    }
    return places;
  }

  Future<List<HanetDepartment>> getListDepartmentByPlace(
    String placeID, {
    int page = 1,
    int size = 24,
    String? keyword,
  }) async {
    List<HanetDepartment> departments = <HanetDepartment>[];
    var respond = await ApiHanlder.post('${DEPARTMENT_PATH}/list', body: {
      "token": EnvironmentController.ACCESS_TOKEN,
      "placeID": placeID,
      "keyword": keyword,
      "page": page,
      "size": size,
    });

    try {
      if (respond.statusCode == 200) {
        HanetRespond respondData = HanetRespond.fromJson(respond.data);
        for (var department in respondData.data) {
          departments.add(HanetDepartment.fromJson(department));
        }
      }
    } catch (e) {
      print(e);
    }
    return departments;
  }
}
