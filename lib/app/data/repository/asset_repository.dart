import 'package:tree_view_challenge/app/data/data_sources/asset/asset_data_source.dart';
import 'package:tree_view_challenge/app/data/models/asset_model.dart';
import 'package:tree_view_challenge/app/data/services/execute_service.dart';

import '../models/default_response_model.dart';

class AssetRepository {
  final AssetDataSource _assetDataSource;

  AssetRepository(this._assetDataSource);

  Future<DefaultResponseModel<List<AssetModel>>> getAll(String companyId) {
    return ExecuteService.tryExecuteAsync(
        () => _assetDataSource.getAll(companyId));
  }
}
