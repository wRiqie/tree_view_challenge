import '../data_sources/asset/asset_data_source.dart';
import '../models/asset_model.dart';
import '../models/default_response_model.dart';
import '../services/execute_service.dart';

class AssetRepository {
  final AssetDataSource _assetDataSource;

  AssetRepository(this._assetDataSource);

  Future<DefaultResponseModel<List<AssetModel>>> getAll(String companyId) {
    return ExecuteService.tryExecuteAsync(
        () => _assetDataSource.getAll(companyId));
  }
}
