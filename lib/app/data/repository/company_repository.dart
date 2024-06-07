import '../data_sources/company/company_data_source.dart';
import '../models/company_model.dart';
import '../models/default_response_model.dart';
import '../services/execute_service.dart';

class CompanyRepository {
  final CompanyDataSource _companyDataSource;

  CompanyRepository(this._companyDataSource);

  Future<DefaultResponseModel<List<CompanyModel>>> getAll() {
    return ExecuteService.tryExecuteAsync(() => _companyDataSource.getAll());
  }
}
