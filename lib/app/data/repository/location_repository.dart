import '../data_sources/location/location_data_source.dart';
import '../models/default_response_model.dart';
import '../models/location_model.dart';
import '../services/execute_service.dart';

class LocationRepository {
  final LocationDataSource _locationDataSource;

  LocationRepository(this._locationDataSource);

  Future<DefaultResponseModel<List<LocationModel>>> getAll(String companyId) {
    return ExecuteService.tryExecuteAsync(
        () => _locationDataSource.getAll(companyId));
  }
}
