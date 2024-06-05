import 'package:get/get.dart';
import 'package:tree_view_challenge/app/core/values/constants.dart';
import 'package:tree_view_challenge/app/core/values/snackbars.dart';
import 'package:tree_view_challenge/app/data/models/company_model.dart';
import 'package:tree_view_challenge/app/data/repository/company_repository.dart';

class HomeController extends GetxController {
  final CompanyRepository _companyRepository;
  final companies = RxList<CompanyModel>();

  final isLoading = RxBool(false);

  HomeController(this._companyRepository);

  @override
  void onInit() {
    super.onInit();
    _loadCompanies();
  }

  void _loadCompanies() async {
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
