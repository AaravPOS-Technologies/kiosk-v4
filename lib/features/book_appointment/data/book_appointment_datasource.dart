import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kiosk_app/features/book_appointment/model/service_professional_model.dart';

class BookAppointmentDatasource {
  BookAppointmentDatasource();

  /// fetch service professionals
  Future<List<ServiceProfessionalModel>> fetchServiceProfessionals() async {
    final result = [
      ServiceProfessionalModel(
        id: 1,
        name: 'Jerry Wilson',
        image: 'https://i.pravatar.cc/150?img=12',
        availability: 'Today',
      ),
      ServiceProfessionalModel(
        id: 2,
        name: 'Tom Curtie',
        image: 'https://i.pravatar.cc/150?img=13',
        availability: 'Today',
      ),
      ServiceProfessionalModel(
        id: 3,
        name: 'Moody Vager',
        image: 'https://plus.unsplash.com/premium_photo-1683121366070-5ceb7e007a97',
        availability: 'Tomorrow',
      ),
      ServiceProfessionalModel(
        id: 4,
        name: 'Miracle George',
        image: 'https://i.pravatar.cc/150?img=15',
        availability: 'Sunday, Aug 16',
      ),
      ServiceProfessionalModel(
        id: 5,
        name: 'Roger Gouse',
        image: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
        availability: 'Sunday, Aug 2',
      ),
      ServiceProfessionalModel(
        id: 6,
        name: 'Miracle George',
        image: 'https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925',
        availability: 'Today',
      ),
      ServiceProfessionalModel(
        id: 7,
        name: 'Roger Gouse',
        image: 'https://plus.unsplash.com/premium_photo-1671656349322-41de944d259b',
        availability: 'Sunday, Aug 2',
      ),
    ];

    return result;
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
