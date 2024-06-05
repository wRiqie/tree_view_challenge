import 'package:tree_view_challenge/app/data/data_sources/company/company_data_source.dart';
import 'package:tree_view_challenge/app/data/models/company_model.dart';
import 'package:tree_view_challenge/app/data/services/http/http_service.dart';

class CompanyDataSourceApiImp implements CompanyDataSource {
  final HttpService _httpService;

  CompanyDataSourceApiImp(this._httpService);

  @override
  Future<List<CompanyModel>> getAll() async {
    final response = await _httpService.get('/companies');

    return (response.data as List).map((e) => CompanyModel.fromMap(e)).toList();
  }
}
