import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk_app/core/constants/color_constants.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';
import 'package:kiosk_app/features/home/bloc/home_bloc.dart';
import 'package:kiosk_app/generated/assets_const.dart';

class HomeMobileView extends StatelessWidget {
  final HomeBloc homeBloc;

  const HomeMobileView({
    super.key,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Header: Logo & Action Buttons
            _buildTopBar(),

            40.height,

            // Welcome Text
            Text(
              "Welcome",
              style: TextStyleConstants.h1(size: 24),
              textAlign: TextAlign.center,
            ),
            6.height,
            Text(
              "What would you like to do today?",
              style: TextStyleConstants.bodyMedium(size: 13).copyWith(
                color: ColorConstants.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            32.height,

            // Vertical Cards for Mobile
            _buildWalkInCard(),
            16.height,
            _buildBookAppointmentCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          Assets.imgLogin,
          height: 28,
          fit: BoxFit.contain,
        ),
        Row(
          children: [
            _buildIconButton(
              icon: Icons.refresh_rounded,
              onTap: () => homeBloc.add(HomeRefreshEvent()),
            ),
            10.width,
            _buildIconButton(
              icon: Icons.logout_rounded,
              onTap: () => homeBloc.add(HomeLogoutEvent()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ColorConstants.borderColor.withOpacity(0.8),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: ColorConstants.textPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildWalkInCard() {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => homeBloc.add(WalkInTapEvent()),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 215,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFF03A4E),
                ColorConstants.primaryColor,
                Color(0xFFD32235),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.primaryColor.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.icWalkIn,
                      ),
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Walk In",
                          style: TextStyleConstants.h2(size: 24).copyWith(
                            color: Colors.white,
                          ),
                        ),
                        3.height,
                        Text(
                          "Get service today",
                          style: TextStyleConstants.bodyMedium(size: 16).copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: ColorConstants.primaryColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookAppointmentCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => homeBloc.add(BookAppointmentTapEvent()),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 215,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ColorConstants.borderColor.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.icCalendar,
                      ),
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Book Appointment",
                          style: TextStyleConstants.h2(size: 24),
                        ),
                        3.height,
                        Text(
                          "Schedule a new service session",
                          style: TextStyleConstants.bodyMedium(size: 16).copyWith(
                            color: ColorConstants.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
