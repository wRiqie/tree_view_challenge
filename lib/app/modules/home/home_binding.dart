import 'package:get/get.dart';

import '../../data/repository/company_repository.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyRepository>(() => CompanyRepository(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
