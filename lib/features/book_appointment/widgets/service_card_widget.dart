import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/color_constants.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';
import 'package:kiosk_app/features/book_appointment/model/services_model.dart';

class ServiceCardWidget extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceCardWidget({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = service.selected;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 104),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFDECEE) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? ColorConstants.primaryColor : const Color(0xFFECECEC),
              width: isSelected ? 1.2 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleConstants.h3(size: 16),
                  ),
                  4.height,
                  Text(
                    service.duration,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleConstants.label(size: 12),
                  ),
                ],
              ),
              8.height,
              Text(
                service.priceLabel,
                style: TextStyleConstants.h2(size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
