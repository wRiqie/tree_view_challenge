import 'package:tree_view_challenge/app/data/models/asset_model.dart';

abstract class AssetDataSource {
  Future<List<AssetModel>> getAll(String companyId);
}
