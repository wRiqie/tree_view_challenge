import 'package:tree_view_challenge/app/data/data_sources/company/company_data_source.dart';
import 'package:tree_view_challenge/app/data/models/company_model.dart';
import 'package:tree_view_challenge/app/data/models/default_response_model.dart';
import 'package:tree_view_challenge/app/data/services/execute_service.dart';

class CompanyRepository {
  final CompanyDataSource _companyDataSource;

  CompanyRepository(this._companyDataSource);

  Future<DefaultResponseModel<List<CompanyModel>>> getAll() {
    return ExecuteService.tryExecuteAsync(() => _companyDataSource.getAll());
  }
}
