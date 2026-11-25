import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_app/features/book_appointment/data/book_appointment_repo.dart';
import 'package:kiosk_app/features/book_appointment/model/service_professional_model.dart';
import 'package:kiosk_app/features/book_appointment/model/services_model.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

class BookAppointmentBloc extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  final BookAppointmentRepository _repository;

  BookAppointmentBloc({
    required BookAppointmentRepository repository,
  })  : _repository = repository,
        super(const BookAppointmentState()) {
    on<ServiceProfessionalListEvent>(_loadServiceProfessionals);
    on<LoadServicesEvent>(_onLoadServices);
    on<SelectCategory>(_onSelectCategory);
    on<SelectSubCategory>(_onSelectSubCategory);
    on<BackToCategoriesEvent>(_onBackToCategories);
    on<ToggleServiceGroupExpansionEvent>(_onToggleServiceGroupExpansion);
    on<ToggleServiceSelectionEvent>(_onToggleServiceSelection);
  }

  Future<void> _loadServiceProfessionals(
    ServiceProfessionalListEvent event,
    Emitter<BookAppointmentState> emit,
  ) async {
    try {
      final result = await _repository.fetchProfessionals();
      emit(state.copyWith(professionalsList: List.of(result)));
    } catch (e) {
      debugPrint("Load Service Professionals:::$e");
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadServices(
    LoadServicesEvent event,
    Emitter<BookAppointmentState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await _repository.getServices();

      emit(
        state.copyWith(
          superCategories: response.superCategories,
          standaloneCategories: response.standaloneCategories,
          serviceGroups: response.serviceGroups,
          isLoading: false,
          errorMessage: "",
        ),
      );
    } catch (e) {
      debugPrint("Load Services:::$e");
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onSelectCategory(
    SelectCategory event,
    Emitter<BookAppointmentState> emit,
  ) {
    emit(state.copyWith(
      selectedCategory: event.categoryId,
      showServices: true,
    ));
  }

  void _onSelectSubCategory(
    SelectSubCategory event,
    Emitter<BookAppointmentState> emit,
  ) {
    emit(state.copyWith(selectedSubCategory: event.subCategoryId));
  }

  void _onBackToCategories(
    BackToCategoriesEvent event,
    Emitter<BookAppointmentState> emit,
  ) {
    emit(state.copyWith(
      clearSelectedCategory: true,
      clearSelectedSubCategory: true,
      showServices: false,
    ));
  }

  void _onToggleServiceGroupExpansion(
    ToggleServiceGroupExpansionEvent event,
    Emitter<BookAppointmentState> emit,
  ) {
    final groups = state.serviceGroups;
    if (groups == null || groups.isEmpty) return;

    final updatedGroups = groups.map((group) {
      if (group.id == event.groupId) {
        return group.copyWith(expanded: !group.expanded);
      }
      return group;
    }).toList();

    emit(state.copyWith(serviceGroups: updatedGroups));
  }

  void _onToggleServiceSelection(
    ToggleServiceSelectionEvent event,
    Emitter<BookAppointmentState> emit,
  ) {
    final groups = state.serviceGroups;
    if (groups == null || groups.isEmpty) return;

    final updatedGroups = groups.map((group) {
      if (group.id == event.groupId) {
        final updatedServices = group.services.map((service) {
          if (service.id == event.serviceId) {
            return service.copyWith(selected: !service.selected);
          }
          return service;
        }).toList();
        return group.copyWith(services: updatedServices);
      }
      return group;
    }).toList();

    emit(state.copyWith(serviceGroups: updatedGroups));
  }
}
