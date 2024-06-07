import '../../models/company_model.dart';
import '../../services/http/http_service.dart';
import 'company_data_source.dart';

class CompanyDataSourceApiImp implements CompanyDataSource {
  final HttpService _httpService;

  CompanyDataSourceApiImp(this._httpService);

  @override
  Future<List<CompanyModel>> getAll() async {
    final response = await _httpService.get('/companies');

    return (response.data as List).map((e) => CompanyModel.fromMap(e)).toList();
  }
}
