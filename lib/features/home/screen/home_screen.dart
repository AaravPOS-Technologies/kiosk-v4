import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_app/core/constants/color_constants.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/navigation_utils.dart';
import 'package:kiosk_app/core/utils/size_utils.dart';
import 'package:kiosk_app/features/auth/screens/login_screen.dart';
import 'package:kiosk_app/features/book_appointment/screens/select_professionals_screen.dart';
import 'package:kiosk_app/features/home/bloc/home_bloc.dart';
import 'package:kiosk_app/features/home/widgets/home_mobile_view.dart';
import 'package:kiosk_app/features/home/widgets/home_tablet_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Logout',
          style: TextStyleConstants.h2(size: 18),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyleConstants.bodyMedium(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyleConstants.bodyMedium().copyWith(
                color: ColorConstants.textSecondaryColor,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              NavigationUtils.pushAndRemoveUntil(context, const LoginScreen());
            },
            child: Text(
              'Logout',
              style: TextStyleConstants.button(size: 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state.selectedAction == HomeActionType.logout) {
          _showLogoutDialog();
        } else if (state.selectedAction == HomeActionType.walkIn) {
          NavigationUtils.push(context, const SelectProfetionalsScreen());
        } else if (state.selectedAction == HomeActionType.bookAppointment) {
          NavigationUtils.push(context, const SelectProfetionalsScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.primaryColor,
                    ),
                  )
                : SizeUtils.isTablet(context)
                    ? HomeTabletView(homeBloc: _homeBloc)
                    : HomeMobileView(homeBloc: _homeBloc),
          ),
        );
      },
    );
  }
}
