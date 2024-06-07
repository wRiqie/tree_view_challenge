import '../../models/asset_model.dart';
import '../../services/http/http_service.dart';
import 'asset_data_source.dart';

class AssetDataSourceApiImp implements AssetDataSource {
  final HttpService _httpService;

  AssetDataSourceApiImp(this._httpService);

  @override
  Future<List<AssetModel>> getAll(String companyId) async {
    final response = await _httpService.get('/companies/$companyId/assets');

    return (response.data as List).map((e) => AssetModel.fromMap(e)).toList();
  }
}
