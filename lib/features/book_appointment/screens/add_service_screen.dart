import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/color_constants.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';
import 'package:kiosk_app/core/utils/navigation_utils.dart';
import 'package:kiosk_app/core/utils/size_utils.dart';
import 'package:kiosk_app/features/book_appointment/model/service_professional_model.dart';
import 'package:kiosk_app/features/book_appointment/widgets/service_booking_card.dart';
import 'package:kiosk_app/shared/widgets/adaptive_sheet.dart';
import 'package:kiosk_app/shared/widgets/appbar_widget.dart';
import 'package:kiosk_app/shared/widgets/custom_text_field.dart';
import 'package:kiosk_app/shared/widgets/primary_button.dart';

class AddServiceScreen extends StatefulWidget {
  final ServiceProfessionalModel? professional;
  const AddServiceScreen({super.key, this.professional});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final TextEditingController _txtGuestName = TextEditingController();

  final List<Map<String, dynamic>> services = [
    {
      'name': 'Beard Trim',
      'duration': 30,
      'price': 25.0,
    },
  ];

  int guestCount = 1;

  double get totalPrice {
    return services.fold(
      0.0,
      (sum, service) => sum + service['price'],
    );
  }

  int get totalMinutes {
    return services.fold(
      0,
      (sum, service) => sum + (service['duration'] as int),
    );
  }

  void addService() {
    setState(() {
      services.add({
        'name': 'Haircut',
        'duration': 30,
        'price': 35.0,
      });
    });
  }

  void addGuest() {
    openServiceSelection();
  }

  void continueBooking() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Add any guest & services?',
      ),

      // Main screen content
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          children: [
            BookingServiceCard(
              professional: widget.professional,
            ),

            16.height,

            // Add new guest widget
            addGuestCard(),
          ],
        ),
      ),

      // bottom booking amount widget
      bottomNavigationBar: bottomBookingBar(),
    );
  }

  Future<void> openServiceSelection() async {
    _txtGuestName.clear();
    final selectedService = await AdaptiveSheet.show<String>(
      context: context,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Add Guest",
                    style: TextStyleConstants.h3(size: 16),
                  ),
                ),

                // close button
                if (SizeUtils.isMobile(context) == true)
                  GestureDetector(
                    onTap: () {
                      NavigationUtils.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.white,
                          border: Border.all(color: Theme.of(context).dividerColor, width: 1.5)),
                      child: Icon(Icons.close),
                    ),
                  )
              ],
            ),
            20.height,
            CustomTextField(
              controller: _txtGuestName,
              label: "Full Name",
              hint: "Enter name",
              isShowRequireIcon: true,
              textInputAction: TextInputAction.done,
            ),
            16.height,
            Spacer(),
            PrimaryButton(
              label: "Add",
              onTap: () {
                NavigationUtils.pop(context);
              },
            )
          ],
        ),
      ),
    );

    if (selectedService == null || !mounted) return;

    debugPrint('Selected service: $selectedService');

    // Add selected service to the current guest here.
  }

  // ADD GUEST
  Widget addGuestCard() {
    return InkWell(
      onTap: addGuest,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 88,
        width: 424,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFDCDCDC),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.person_add_alt_1,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add a guest', style: TextStyleConstants.h2(size: 14)),
                  SizedBox(height: 3),
                  Text('Their professionals, services, and times',
                      style: TextStyleConstants.label(size: 12)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Add',
                  style: TextStyleConstants.h2(size: 12)
                      .copyWith(color: Theme.of(context).primaryColor)),
            ),
          ],
        ),
      ),
    );
  }

  // BOTTOM PRICE & CONTINUE BUTTON
  Widget bottomBookingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeUtils.isMobile(context) ? 0 : 32),
      padding: const EdgeInsets.fromLTRB(17, 12, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: SizeUtils.isMobile(context)
            ? null
            : BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyleConstants.h2(size: 20)),
                  const SizedBox(height: 3),
                  Text(
                    '${services.length} Services • $totalMinutes min',
                    style: TextStyleConstants.label(size: 12),
                  ),
                ],
              ),
            ),
            12.width,
            SizedBox(
              width: 143,
              height: 36,
              child: ElevatedButton(
                onPressed: continueBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
