import 'package:tree_view_challenge/app/data/data_sources/location/location_data_source.dart';
import 'package:tree_view_challenge/app/data/models/location_model.dart';
import 'package:tree_view_challenge/app/data/services/http/http_service.dart';

class LocationDataSourceApiImp implements LocationDataSource {
  final HttpService _httpService;

  LocationDataSourceApiImp(this._httpService);

  @override
  Future<List<LocationModel>> getAll(String companyId) async {
    final response = await _httpService.get('/companies/$companyId/locations');

    return (response.data as List)
        .map((e) => LocationModel.fromMap(e))
        .toList();
  }
}
