class ServiceResponseModel {
  final String screenTitle;
  final List<ServiceCategoryModel> superCategories;
  final List<ServiceCategoryModel> standaloneCategories;
  final List<ServiceGroupModel> serviceGroups;

  ServiceResponseModel({
    required this.screenTitle,
    required this.superCategories,
    required this.standaloneCategories,
    required this.serviceGroups,
  });

  factory ServiceResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ServiceResponseModel(
      screenTitle: json['screenTitle'] ?? '',
      superCategories: (json['superCategories'] as List? ?? [])
          .map((e) => ServiceCategoryModel.fromJson(e))
          .toList(),
      standaloneCategories: (json['standaloneCategories'] as List? ?? [])
          .map((e) => ServiceCategoryModel.fromJson(e))
          .toList(),
      serviceGroups:
          (json['serviceGroups'] as List? ?? []).map((e) => ServiceGroupModel.fromJson(e)).toList(),
    );
  }
}

class ServiceCategoryModel {
  final String id;
  final String name;
  final String subtitle;
  final List<String> subCategories;
  final List<dynamic> services;

  ServiceCategoryModel({
    required this.id,
    required this.name,
    required this.subtitle,
    this.subCategories = const [],
    this.services = const [],
  });

  factory ServiceCategoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ServiceCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      subtitle: json['subtitle'] ?? '',
      subCategories: List<String>.from(
        json['subCategories'] ?? [],
      ),
      services: json['services'] ?? [],
    );
  }
}

class ServiceModel {
  final String id;
  final String name;
  final String duration;
  final double price;
  final double maxPrice;
  final String priceLabel;
  final bool selected;

  ServiceModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.maxPrice,
    required this.priceLabel,
    this.selected = false,
  });

  factory ServiceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      duration: json['duration'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      maxPrice: (json['maxPrice'] ?? 0).toDouble(),
      priceLabel: json['priceLabel'] ?? '',
      selected: json['selected'] ?? false,
    );
  }

  ServiceModel copyWith({
    String? id,
    String? name,
    String? duration,
    double? price,
    double? maxPrice,
    String? priceLabel,
    bool? selected,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      maxPrice: maxPrice ?? this.maxPrice,
      priceLabel: priceLabel ?? this.priceLabel,
      selected: selected ?? this.selected,
    );
  }
}

class ServiceGroupModel {
  final String id;
  final String categoryId;
  final String name;
  final int count;
  final bool expanded;
  final List<ServiceModel> services;

  ServiceGroupModel({
    required this.id,
    this.categoryId = '',
    required this.name,
    required this.count,
    required this.expanded,
    required this.services,
  });

  factory ServiceGroupModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ServiceGroupModel(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
      expanded: json['expanded'] ?? false,
      services: (json['services'] as List? ?? [])
          .map(
            (e) => ServiceModel.fromJson(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList(),
    );
  }

  ServiceGroupModel copyWith({
    String? id,
    String? categoryId,
    String? name,
    int? count,
    bool? expanded,
    List<ServiceModel>? services,
  }) {
    return ServiceGroupModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      count: count ?? this.count,
      expanded: expanded ?? this.expanded,
      services: services ?? this.services,
    );
  }
}
