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
}
