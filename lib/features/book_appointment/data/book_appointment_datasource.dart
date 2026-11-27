import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kiosk_app/features/book_appointment/model/service_professional_model.dart';

class BookAppointmentDatasource {
  BookAppointmentDatasource();

  /// fetch service professionals from json asset
  Future<List<ServiceProfessionalModel>> fetchServiceProfessionals() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/service_professionals.json',
      );

      final List<dynamic> data = jsonDecode(response) as List<dynamic>;

      return data
          .map((item) => ServiceProfessionalModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load service professionals: $e');
    }
  }

  Future<Map<String, dynamic>> fetchServices() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/services.json',
      );

      return jsonDecode(response) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load services: $e');
    }
  }
}
