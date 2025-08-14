import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/splash/splash_screen.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TripitifyApp(),
    ),
  );
}

class TripitifyApp extends StatelessWidget {
  const TripitifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.getRoutes(),
      title: 'Tripitify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display', // You can change this to your preferred font
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}