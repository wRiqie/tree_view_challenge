import 'package:get/get.dart';

import '../../core/values/constants.dart';
import '../../core/values/snackbars.dart';
import '../../data/models/company_model.dart';
import '../../data/repository/company_repository.dart';

class HomeController extends GetxController {
  final CompanyRepository _companyRepository;
  final companies = RxList<CompanyModel>();

  final isLoading = RxBool(false);

  HomeController(this._companyRepository);

  @override
  void onInit() {
    super.onInit();
    loadCompanies();
  }

  void loadCompanies() async {
    isLoading.value = true;
    final response = await _companyRepository.getAll();
    if (response.isSuccess) {
      companies.value = response.data ?? [];
    } else {
      ErrorSnackbar(Get.context!, message: Constants.defaultError);
    }
    isLoading.value = false;
  }
}
