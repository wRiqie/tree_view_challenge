import '../../models/company_model.dart';

abstract class CompanyDataSource {
  Future<List<CompanyModel>> getAll();
}
