part of 'book_appointment_bloc.dart';

@immutable
abstract class BookAppointmentEvent {}

class ServiceProfessionalListEvent extends BookAppointmentEvent {
  ServiceProfessionalListEvent();
}

class LoadServicesEvent extends BookAppointmentEvent {}

class SelectCategory extends BookAppointmentEvent {
  final String categoryId;
  SelectCategory(this.categoryId);
}

class SelectSubCategory extends BookAppointmentEvent {
  final String subCategoryId;
  SelectSubCategory(this.subCategoryId);
}

class BackToCategoriesEvent extends BookAppointmentEvent {}

class ToggleServiceGroupExpansionEvent extends BookAppointmentEvent {
  final String groupId;
  ToggleServiceGroupExpansionEvent(this.groupId);
}

class ToggleServiceSelectionEvent extends BookAppointmentEvent {
  final String groupId;
  final String serviceId;
  ToggleServiceSelectionEvent({
    required this.groupId,
    required this.serviceId,
  });
}
