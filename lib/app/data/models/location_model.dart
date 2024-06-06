class LocationModel {
  final String id;
  final String name;
  final String? parentId;

  LocationModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
    );
  }
}
