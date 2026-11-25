import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiosk_app/core/utils/navigation_utils.dart';
import 'package:kiosk_app/features/auth/screens/login_screen.dart';
import 'package:kiosk_app/generated/assets_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _initAnimationAndRedirect();
  }

  void _initAnimationAndRedirect() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    await _controller.forward();
    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    NavigationUtils.pushReplacement(context, const LoginScreen());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = math.sqrt(size.width * size.width + size.height * size.height);
    final targetScale = (diagonal / 200.0) * 1.15;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              final scale = 1.0 + (_scaleAnimation.value * (targetScale - 1.0));
              return Transform.scale(
                scale: scale,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            },
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: SvgPicture.asset(Assets.icAppLogo),
            ),
          ),
        ],
      ),
    );
  }
}
