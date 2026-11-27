class ServiceProfessionalModel {
  final int id;
  final String name;
  final String? image;
  final String? availability;
  final bool isAvailable;

  ServiceProfessionalModel({
    required this.id,
    required this.name,
    this.image,
    this.availability,
    this.isAvailable = true,
  });

  factory ServiceProfessionalModel.fromJson(Map<String, dynamic> json) {
    return ServiceProfessionalModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      image: json['image'] as String?,
      availability: json['availability'] as String?,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'availability': availability,
      'isAvailable': isAvailable,
    };
  }
}
