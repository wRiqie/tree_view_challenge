import 'package:get/get.dart';

import 'assets_controller.dart';

class AssetsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsController>(() => AssetsController());
  }
}
