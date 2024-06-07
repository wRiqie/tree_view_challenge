import 'package:get/get.dart';

import 'app/data/data_sources/asset/asset_data_source.dart';
import 'app/data/data_sources/asset/asset_data_source_api_imp.dart';
import 'app/data/data_sources/company/company_data_source.dart';
import 'app/data/data_sources/company/company_data_source_api_imp.dart';
import 'app/data/data_sources/location/location_data_source.dart';
import 'app/data/data_sources/location/location_data_source_api_imp.dart';
import 'app/data/services/http/http_service.dart';
import 'app/data/services/http/http_service_dio_imp.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // DataServices
    Get.lazyPut<HttpService>(() => HttpServiceDioImp());

    // DataSources
    Get.put<CompanyDataSource>(CompanyDataSourceApiImp(Get.find()),
        permanent: true);
    Get.put<AssetDataSource>(AssetDataSourceApiImp(Get.find()),
        permanent: true);
    Get.put<LocationDataSource>(LocationDataSourceApiImp(Get.find()),
        permanent: true);
  }
}
