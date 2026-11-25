import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';
import 'package:kiosk_app/features/book_appointment/model/service_professional_model.dart';

class BookingServiceCard extends StatefulWidget {
  final ServiceProfessionalModel? professional;
  const BookingServiceCard({super.key, this.professional});

  @override
  State<BookingServiceCard> createState() => _BookingServiceCardState();
}

class _BookingServiceCardState extends State<BookingServiceCard> {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Beard Trim',
      'duration': '30 min',
      'price': 25.00,
    },
  ];

  double get totalPrice => services.fold(
        0,
        (sum, item) => sum + (item['price'] as double),
      );

  int get totalMinutes => services.fold(
        0,
        (sum, item) =>
            sum +
            int.parse(
              (item['duration'] as String).split(' ').first,
            ),
      );

  void addService() {
    setState(() {
      services.add({
        'name': 'Haircut',
        'duration': '30 min',
        'price': 35.00,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD8D8D8),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 3,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _guestSection(),
                  _professionalSection(widget.professional),
                  _serviceSection(),
                  _addServiceSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _guestSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PRIMARY GUEST',
            style: TextStyleConstants.h2().copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: Text('You', style: TextStyleConstants.h2(size: 16)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text('You',
                    style: TextStyleConstants.h2(size: 12)
                        .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('${services.length} services • $totalMinutes min • 1 professionals',
              style: TextStyleConstants.label(size: 12).copyWith(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _professionalSection(ServiceProfessionalModel? professional) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE6E6E6)),
          bottom: BorderSide(color: Color(0xFFE6E6E6)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.green,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFE8E8E8),
              backgroundImage: NetworkImage(professional?.image ?? ''),
            ),
          ),
          10.width,
          Text(
            'with ',
            style: TextStyleConstants.label(size: 12),
          ),
          Text(
            professional?.name ?? '',
            style: TextStyleConstants.h2(size: 12),
          ),
          const SizedBox(width: 5),
          Text('• 30 min', style: TextStyleConstants.label(size: 12)),
        ],
      ),
    );
  }

  Widget _serviceSection() {
    return Column(
      children: services.map((service) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE6E6E6)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service['name'], style: TextStyleConstants.h2(size: 14)),
                    const SizedBox(height: 4),
                    Text(service['duration'], style: TextStyleConstants.label(size: 12)),
                  ],
                ),
              ),
              Text('\$${(service['price'] as double).toStringAsFixed(2)}',
                  style: TextStyleConstants.h2(size: 14)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _addServiceSection() {
    return InkWell(
      onTap: addService,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
              size: 22,
            ),
            12.width,
            Text('Add another service for you', style: TextStyleConstants.h3(size: 14)),
          ],
        ),
      ),
    );
  }
}
