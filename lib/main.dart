import 'package:dtt_view_houses_app/controllers/geolocator_controller.dart';
import 'package:dtt_view_houses_app/controllers/internet_controller.dart';
import 'package:dtt_view_houses_app/controllers/theme_controller.dart';
import 'package:dtt_view_houses_app/controllers/wishlist_controller.dart';
import 'package:dtt_view_houses_app/repository/api_service.dart';
import 'package:dtt_view_houses_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GeolocatorController(),
        ),
        ChangeNotifierProvider(
          create: (_) => InternetController(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384, 592),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemeController>().isDarkMode
              ? darkMode
              : lightMode,
          home: HomeScreen(),
        );
      },
    );
  }
}
