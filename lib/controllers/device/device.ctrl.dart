// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:hanet/controllers/api/api.ctrl.dart';
import 'package:hanet/controllers/config/env.ctrl.dart';
import 'package:hanet/models/device/device.d.dart';
import 'package:hanet/models/respond/respond.d.dart';

class DeviceController extends GetxController {
  RxList<HanetDevice> devices = <HanetDevice>[].obs;

  static const String DEVICE_PATH = "/device";
  static const String GET_LIST_DEVICE = "/getListDevice";

  Future<List<HanetDevice>> getAllDevices() async {
    List<HanetDevice> devices = [];
    var respond = await ApiHanlder.post(DEVICE_PATH + GET_LIST_DEVICE, body: {
      "token": EnvironmentController.ACCESS_TOKEN,
    });
    try {
      if (respond.statusCode == 200) {
        HanetRespond respondData = HanetRespond.fromJson(respond.data);
        for (var device in respondData.data) {
          devices.add(HanetDevice.fromJson(device));
        }
      }
    } catch (e) {
      print(e);
    }
    return devices;
  }
}
