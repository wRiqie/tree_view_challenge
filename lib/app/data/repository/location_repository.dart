import 'package:tree_view_challenge/app/data/data_sources/location/location_data_source.dart';
import 'package:tree_view_challenge/app/data/models/location_model.dart';
import 'package:tree_view_challenge/app/data/services/execute_service.dart';

import '../models/default_response_model.dart';

class LocationRepository {
  final LocationDataSource _locationDataSource;

  LocationRepository(this._locationDataSource);

  Future<DefaultResponseModel<List<LocationModel>>> getAll(String companyId) {
    return ExecuteService.tryExecuteAsync(
        () => _locationDataSource.getAll(companyId));
  }
}
