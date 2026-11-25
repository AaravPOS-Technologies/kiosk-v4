import 'package:flutter/material.dart';
import 'package:kiosk_app/features/book_appointment/data/book_appointment_datasource.dart';
import 'package:kiosk_app/features/book_appointment/model/service_professional_model.dart';
import 'package:kiosk_app/features/book_appointment/model/services_model.dart';

class BookAppointmentRepository {
  final BookAppointmentDatasource datasource;

  BookAppointmentRepository({required this.datasource});

  /// fetch service professionals
  Future<List<ServiceProfessionalModel>> fetchProfessionals() async {
    try {
      final result = await datasource.fetchServiceProfessionals();

      return result;
    } catch (e) {
      debugPrint("Repository error: $e");
      rethrow;
    }
  }

  Future<ServiceResponseModel> getServices() async {
    final json = await datasource.fetchServices();

    return ServiceResponseModel.fromJson(json);
  }
}
