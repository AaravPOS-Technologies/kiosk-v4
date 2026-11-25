import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/app_labels.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:kiosk_app/core/theme/app_theme.dart';
import 'package:kiosk_app/features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: MaterialApp(
            title: AppLabels.appName,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.lightTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
