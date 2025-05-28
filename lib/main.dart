import 'package:flutter/material.dart';
import 'package:laundream/presentation/admin/home.dart';
import 'package:laundream/presentation/home/promo_notification.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Penting agar plugin native bekerja
  await PromoNotificationService.init(); // Panggil inisialisasi notifikasi
  await initializeDateFormatting(
      'id_ID', null); // inisialisasi format tanggal Indonesia
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
        dialogBackgroundColor:
            Colors.white, // Paksa background dialog jadi putih
        cardColor: Colors.white, // Jika pakai Card dalam dialog, ini juga bantu
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          surface:
              Colors.white, // (opsional) permukaan seperti dialog jadi putih
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
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
      ),
      home: HomeAdmin(),
    );
  }
}
