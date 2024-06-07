import '../../core/values/app_images.dart';
import '../enums/sensor_type_enum.dart';
import '../enums/status_enum.dart';

class AssetModel {
  final String id;
  final String? locationId;
  final String name;
  final String? parentId;
  final StatusEnum? status;
  final String? gatewayId;
  final String? sensorId;
  final SensorTypeEnum? sensorType;

  AssetModel({
    required this.id,
    this.locationId,
    required this.name,
    this.parentId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.sensorId,
  });

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'],
      locationId: map['locationId'],
      name: map['name'],
      parentId: map['parentId'],
      sensorType: map['sensorType'] != null
          ? SensorTypeEnum.getByName(map['sensorType'])
          : null,
      status:
          map['status'] != null ? StatusEnum.getByName(map['status']) : null,
      gatewayId: map['gatewayId'],
      sensorId: map['sensorId'],
    );
  }

  String getLeadingIcon() {
    return sensorType != null ? AppImages.componentCube : AppImages.cube;
  }

  String? getTrailingIcon() {
    if (sensorType == null) return null;
    if (sensorType!.isEnergy) {
      return AppImages.bolt;
    } else if (status?.isAlert ?? false) {
      return AppImages.point;
    }
    return null;
  }
}
