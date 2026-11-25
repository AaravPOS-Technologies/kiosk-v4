import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/color_constants.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';
import 'package:kiosk_app/features/book_appointment/model/services_model.dart';
import 'package:kiosk_app/features/book_appointment/widgets/service_card_widget.dart';

class ServiceGroupWidget extends StatelessWidget {
  final ServiceGroupModel group;
  final VoidCallback onToggleExpand;
  final void Function(ServiceModel service) onServiceTap;

  const ServiceGroupWidget({
    super.key,
    required this.group,
    required this.onToggleExpand,
    required this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subcategory
        Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: onToggleExpand,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFEFEFEF),
                  width: 0.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(group.name, style: TextStyleConstants.h3(size: 16)),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Color(0xFFBDBDBD),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${group.count}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontFamily: TextStyleConstants.fontFamilyPoppin,
                        ),
                      ),
                    ),
                  ),
                  8.width,
                  Icon(
                    group.expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: ColorConstants.textPrimaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Services Grid
        if (group.expanded && group.services.isNotEmpty) ...[
          12.height,
          _buildServicesGrid(),
        ],
      ],
    );
  }

  Widget _buildServicesGrid() {
    final pairs = <List<ServiceModel>>[];
    for (int i = 0; i < group.services.length; i += 2) {
      pairs.add(
        group.services.sublist(
          i,
          (i + 2 <= group.services.length) ? i + 2 : group.services.length,
        ),
      );
    }

    return Column(
      children: List.generate(pairs.length, (index) {
        final pair = pairs[index];
        return Padding(
          padding: EdgeInsets.only(bottom: index < pairs.length - 1 ? 12 : 0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ServiceCardWidget(
                    service: pair[0],
                    onTap: () => onServiceTap(pair[0]),
                  ),
                ),
                12.width,
                Expanded(
                  child: pair.length > 1
                      ? ServiceCardWidget(
                          service: pair[1],
                          onTap: () => onServiceTap(pair[1]),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
