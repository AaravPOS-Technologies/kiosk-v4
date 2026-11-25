part of 'book_appointment_bloc.dart';

@immutable
class BookAppointmentState {
  final List<ServiceProfessionalModel> professionalsList;
  final bool? isLoading;
  final String? errorMessage;

  // services
  final List<ServiceCategoryModel>? superCategories;
  final List<ServiceCategoryModel>? standaloneCategories;
  final List<ServiceGroupModel>? serviceGroups;

  final String? selectedCategory;
  final String? selectedSubCategory;
  final bool? showServices;

  const BookAppointmentState({
    this.professionalsList = const [],
    this.isLoading = false,
    this.errorMessage = "",
    this.superCategories = const [],
    this.standaloneCategories = const [],
    this.serviceGroups = const [],
    this.selectedCategory,
    this.selectedSubCategory,
    this.showServices = false,
  });

  List<ServiceGroupModel> get filteredServiceGroups {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return serviceGroups ?? [];
    }

    final catId = selectedCategory!.toLowerCase();

    //  Direct match by categoryId
    final matchedByCategoryId =
        (serviceGroups ?? []).where((g) => g.categoryId.toLowerCase() == catId).toList();
    if (matchedByCategoryId.isNotEmpty) {
      return matchedByCategoryId;
    }

    // Match by category's subCategories list
    final allCategories = [
      ...(superCategories ?? []),
      ...(standaloneCategories ?? []),
    ];

    final category = allCategories.firstWhere(
      (c) => c.id.toLowerCase() == catId,
      orElse: () => ServiceCategoryModel(id: '', name: '', subtitle: ''),
    );

    if (category.subCategories.isNotEmpty) {
      final subNames = category.subCategories.map((s) => s.toLowerCase()).toSet();
      final matchedBySubName =
          (serviceGroups ?? []).where((g) => subNames.contains(g.name.toLowerCase())).toList();
      if (matchedBySubName.isNotEmpty) {
        return matchedBySubName;
      }
    }

    //Fallback match by category name
    if (category.name.isNotEmpty) {
      final matchedByName = (serviceGroups ?? [])
          .where((g) => g.name.toLowerCase().contains(category.name.toLowerCase()))
          .toList();
      if (matchedByName.isNotEmpty) {
        return matchedByName;
      }
    }

    return serviceGroups ?? [];
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        professionalsList,
        superCategories,
        standaloneCategories,
        serviceGroups,
        selectedCategory,
        selectedSubCategory,
        showServices,
      ];

  BookAppointmentState copyWith({
    List<ServiceProfessionalModel>? professionalsList,
    bool? isLoading,
    String? errorMessage,
    List<ServiceCategoryModel>? superCategories,
    List<ServiceCategoryModel>? standaloneCategories,
    List<ServiceGroupModel>? serviceGroups,
    String? selectedCategory,
    bool clearSelectedCategory = false,
    String? selectedSubCategory,
    bool clearSelectedSubCategory = false,
    bool? showServices,
  }) {
    return BookAppointmentState(
      professionalsList: professionalsList ?? this.professionalsList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      superCategories: superCategories ?? this.superCategories,
      standaloneCategories: standaloneCategories ?? this.standaloneCategories,
      serviceGroups: serviceGroups ?? this.serviceGroups,
      selectedCategory: clearSelectedCategory ? null : (selectedCategory ?? this.selectedCategory),
      selectedSubCategory:
          clearSelectedSubCategory ? null : (selectedSubCategory ?? this.selectedSubCategory),
      showServices: showServices ?? this.showServices,
    );
  }
}
