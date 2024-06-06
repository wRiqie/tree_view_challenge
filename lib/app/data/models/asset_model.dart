class AssetModel {
  final String id;
  final String? locationId;
  final String name;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? sensorId;

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
      sensorType: map['sensorType'],
      status: map['status'],
      gatewayId: map['gatewayId'],
      sensorId: map['sensorId'],
    );
  }
}
