import 'package:flutter/material.dart';
import 'package:flutter_application/login_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 234, 237, 248),
        fontFamily: 'AmazonEmber', 
        textTheme: 
            TextTheme(
                bodyLarge: TextStyle(fontSize: 12),
                bodyMedium: TextStyle(fontSize: 10),
                displayLarge: TextStyle(fontSize: 18),
                displayMedium: TextStyle(fontSize: 16),
                titleMedium: TextStyle(fontSize: 14),
              ),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.merriweather().copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: Mobilelogin(), 
    );
  }
} 