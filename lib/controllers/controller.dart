import 'package:get/get.dart';
import 'package:hanet/controllers/config/env.ctrl.dart';
import 'package:hanet/controllers/config/menu.ctrl.dart';
import 'package:hanet/controllers/device/device.ctrl.dart';
import 'package:hanet/controllers/person/person.ctrl.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/models/department/department.d.dart';

class RootController {
  // init getx controller with put method and init other controller
  static void initControllers() {
    // other controller
    EnvironmentController.setUpEnvData();
    // getx controller
    Get.put(MenuItemController());
    Get.put(DeviceController());
    Get.put(PersonController());
    Get.put(PlaceController());
  }

  static Future<void> initData() async {
    print("call init data");
    // get all places
    final placeCtrl = Get.find<PlaceController>();
    var placeList = await placeCtrl.getAllPlaces();
    placeCtrl.places.clear();
    placeCtrl.places.addAll(placeList);
    // get all devices
    final deviceCtrl = Get.find<DeviceController>();
    var deviceList = await deviceCtrl.getAllDevices();
    deviceCtrl.devices.clear();
    deviceCtrl.devices.addAll(deviceList);
    //get all departments for places
    placeCtrl.departmentsMap = {};
    for (var place in placeList) {
      RxList<HanetDepartment> departmentList = <HanetDepartment>[].obs;
      var departments =
          await placeCtrl.getListDepartmentByPlace(place.id.toString());
      departmentList.addAll(departments);
      placeCtrl.departmentsMap[place.id.toString()] = departmentList;
    }
  }
}
