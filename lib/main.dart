import 'package:flutter/material.dart';
import 'package:laundryku/presentation/admin/diskon.dart';
import 'package:laundryku/presentation/admin/home.dart';
import 'package:laundryku/presentation/admin/layanan.dart';
import 'package:laundryku/presentation/admin/laporan.dart';
import 'package:laundryku/presentation/home/rincian_pesanan.dart';
import 'package:laundryku/presentation/login/login_page.dart';
import 'package:laundryku/presentation/registration/registration_page.dart';
import 'package:laundryku/presentation/home/home_screen.dart';
import 'package:laundryku/presentation/home/promo_notification.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Penting agar plugin native bekerja
  await PromoNotificationService.init(); // Panggil inisialisasi notifikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: 'Poppins'),
          displayMedium: TextStyle(fontFamily: 'Poppins'),
          displaySmall: TextStyle(fontFamily: 'Poppins'),
          headlineLarge: TextStyle(fontFamily: 'Poppins'),
          headlineMedium: TextStyle(fontFamily: 'Poppins'),
          headlineSmall: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins'),
          titleMedium: TextStyle(fontFamily: 'Poppins'),
          titleSmall: TextStyle(fontFamily: 'Poppins'),
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          bodySmall: TextStyle(fontFamily: 'Poppins'),
          labelLarge: TextStyle(fontFamily: 'Poppins'),
          labelMedium: TextStyle(fontFamily: 'Poppins'),
          labelSmall: TextStyle(fontFamily: 'Poppins'),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
