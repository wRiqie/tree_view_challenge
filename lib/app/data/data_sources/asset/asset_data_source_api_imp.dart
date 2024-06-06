import 'package:tree_view_challenge/app/data/data_sources/asset/asset_data_source.dart';
import 'package:tree_view_challenge/app/data/models/asset_model.dart';
import 'package:tree_view_challenge/app/data/services/http/http_service.dart';

class AssetDataSourceApiImp implements AssetDataSource {
  final HttpService _httpService;

  AssetDataSourceApiImp(this._httpService);

  @override
  Future<List<AssetModel>> getAll(String companyId) async {
    final response = await _httpService.get('/companies/$companyId/assets');

    return (response.data as List).map((e) => AssetModel.fromMap(e)).toList();
  }
}
