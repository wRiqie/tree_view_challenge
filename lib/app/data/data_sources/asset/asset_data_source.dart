import '../../models/asset_model.dart';

abstract class AssetDataSource {
  Future<List<AssetModel>> getAll(String companyId);
}
