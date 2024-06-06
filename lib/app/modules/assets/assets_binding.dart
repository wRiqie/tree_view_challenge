import 'package:get/get.dart';
import 'package:tree_view_challenge/app/data/repository/asset_repository.dart';
import 'package:tree_view_challenge/app/data/repository/location_repository.dart';

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
