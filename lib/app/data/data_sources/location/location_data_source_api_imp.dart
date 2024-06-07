import '../../models/location_model.dart';
import '../../services/http/http_service.dart';
import 'location_data_source.dart';

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
