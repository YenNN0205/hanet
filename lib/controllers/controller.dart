import 'package:get/get.dart';
import 'package:hanet/controllers/menu.ctrl.dart';

class RootController {
  static void initControllers() {
    Get.put(MenuItemController());
  }
}
