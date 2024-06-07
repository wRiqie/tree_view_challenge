import 'package:get/get.dart';

import '../../data/repository/asset_repository.dart';
import '../../data/repository/location_repository.dart';
import 'assets_controller.dart';

class AssetsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetRepository>(() => AssetRepository(Get.find()));
    Get.lazyPut<LocationRepository>(() => LocationRepository(Get.find()));
    Get.lazyPut<AssetsController>(
        () => AssetsController(Get.find(), Get.find()));
  }
}
