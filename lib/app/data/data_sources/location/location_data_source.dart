import '../../models/location_model.dart';

abstract class LocationDataSource {
  Future<List<LocationModel>> getAll(String companyId);
}
