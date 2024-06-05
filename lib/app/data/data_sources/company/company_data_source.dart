import 'package:tree_view_challenge/app/data/models/company_model.dart';

abstract class CompanyDataSource {
  Future<List<CompanyModel>> getAll();
}
