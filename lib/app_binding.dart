import 'package:get/get.dart';
import 'package:tree_view_challenge/app/data/data_sources/company/company_data_source.dart';
import 'package:tree_view_challenge/app/data/data_sources/company/company_data_source_api_imp.dart';
import 'package:tree_view_challenge/app/data/services/http/http_service.dart';
import 'package:tree_view_challenge/app/data/services/http/http_service_dio_imp.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpService>(() => HttpServiceDioImp());
    Get.lazyPut<CompanyDataSource>(() => CompanyDataSourceApiImp(Get.find()));
  }
}
