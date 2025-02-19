import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import file tampilan HRIS

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HRIS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home:
          DashboardScreen(), // Menggunakan tampilan HRIS sebagai halaman utama
    );
  }
}
