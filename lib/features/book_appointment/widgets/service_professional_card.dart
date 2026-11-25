import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';

import 'package:kiosk_app/features/book_appointment/model/service_professional_model.dart';

class ServiceProfessionalCard extends StatelessWidget {
  final ServiceProfessionalModel? item;
  final VoidCallback? onTap;
  final bool isSelected;
  final double width;

  const ServiceProfessionalCard({
    super.key,
    this.item,
    this.onTap,
    this.isSelected = false,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFF2196F3),
                  width: 1.2,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: _selectedContent(),
      ),
    );
  }

  // Selected professional card
  Widget _selectedContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF68A900),
              width: 2,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            backgroundImage: item?.image != null && item!.image?.isNotEmpty == true
                ? NetworkImage(item?.image ?? '')
                : null,
            child: item?.image == null || item!.image?.isEmpty == true
                ? const Icon(Icons.person, size: 30)
                : null,
          ),
        ),
        8.height,
        Text(
          item?.name ?? '',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyleConstants.h3(),
        ),
        8.height,
        Container(
          width: 40,
          height: 1,
          color: Colors.grey.shade300,
        ),
        8.height,
        Text(
          "Available",
          textAlign: TextAlign.center,
          style: TextStyleConstants.label(size: 12),
        ),
        8.height,
        Text(
          item?.availability ?? '',
          textAlign: TextAlign.center,
          style: TextStyleConstants.label(size: 12),
        ),
      ],
    );
  }
}
