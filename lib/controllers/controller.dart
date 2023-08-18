import 'package:get/get.dart';
import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
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
    Get.put(AttendanceController());
  }

  static Future<void> initData() async {
    print("call init data");

    final placeCtrl = Get.find<PlaceController>();
    final deviceCtrl = Get.find<DeviceController>();
    final personCtrl = Get.find<PersonController>();

    // get all places
    var placeList = await placeCtrl.getAllPlaces();
    placeCtrl.places.clear();
    placeCtrl.places.addAll(placeList);
    // get all devices

    var deviceList = await deviceCtrl.getAllDevices();
    deviceCtrl.devices.clear();
    deviceCtrl.devices.addAll(deviceList);

    //get all departments and people for every place
    placeCtrl.departmentsMap.clear();
    personCtrl.peopleMap.clear();

    for (var place in placeList) {
      String placeID = place.id.toString();
      try {
        var departments = await placeCtrl.getListDepartmentByPlace(placeID);
        placeCtrl.departmentsMap[placeID] = departments;
      } catch (e) {
        print(e);
      }
      try {
        var people = await personCtrl.getPeopleByPlace(placeID);
        personCtrl.peopleMap[placeID] = people;
      } catch (e) {
        print(e);
      }
    }
  }
}
