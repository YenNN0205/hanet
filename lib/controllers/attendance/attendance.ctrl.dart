import 'package:get/get.dart';
import 'package:hanet/controllers/api/api.ctrl.dart';
import 'package:hanet/controllers/config/env.ctrl.dart';
import 'package:hanet/controllers/device/device.ctrl.dart';
import 'package:hanet/models/device/device.d.dart';

import '../../models/attendance/checkin.d.dart';
import '../../models/respond/respond.d.dart';

class AttendanceController extends GetxController {
  Future<List<HanetCheckIn>> getCheckInListInTimestamp({
    required String placeID,
    int? from,
    int? to,
    int type = 0,
    int page = 1,
    int? perPage,
  }) async {
    List<HanetCheckIn> ret = [];
    final deviceCtrl = Get.find<DeviceController>();
    var devicesInPlace = deviceCtrl.devices
        .where((d) => d.placeID.toString() == placeID)
        .toList();
    final respond =
        await ApiHanlder.post("/person/getCheckinByPlaceIdInTimestamp", body: {
      "token": EnvironmentController.ACCESS_TOKEN,
      "placeID": placeID,
      "from": from ?? DateTime.now().copyWith(hour: 7).millisecondsSinceEpoch,
      "to": to ?? DateTime.now().copyWith(hour: 19).millisecondsSinceEpoch,
      "devices": devicesInPlace.map((e) => e.deviceID).join(","),
      "type": type,
      "page": page,
      "perpage": perPage,
    });
    try {
      if (respond.statusCode == 200) {
        HanetRespond respondData = HanetRespond.fromJson(respond.data);
        if (respond.data != null) {
          for (var checkIn in respondData.data) {
            ret.add(HanetCheckIn.fromJson(checkIn));
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return ret;
  }

  Future<List<HanetCheckIn>> getCheckInToday({
    required String placeID,
    String type = "0,1,2",
    required String date,
    int page = 1, // format type: yyyy-MM-dd
    int? perPage,
  }) async {
    List<HanetCheckIn> ret = [];
    final deviceCtrl = Get.find<DeviceController>();
    var devicesInPlace = deviceCtrl.devices
        .where((d) => d.placeID.toString() == placeID)
        .toList();
    final respond =
        await ApiHanlder.post("/person/getCheckinByPlaceIdInDay", body: {
      "token": EnvironmentController.ACCESS_TOKEN,
      "placeID": placeID,
      "devices": devicesInPlace.map((e) => e.deviceID).join(","),
      "type": type,
      "date": date,
      "page": page,
      "perpage": perPage,
    });
    try {
      if (respond.statusCode == 200) {
        HanetRespond respondData = HanetRespond.fromJson(respond.data);
        for (var checkIn in respondData.data) {
          ret.add(HanetCheckIn.fromJson(checkIn));
        }
      }
    } catch (e) {
      print(e);
    }
    return ret;
  }
}
