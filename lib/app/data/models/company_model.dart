class CompanyModel {
  final String id;
  final String name;

  CompanyModel({
    required this.id,
    required this.name,
  });

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
