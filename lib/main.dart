import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/database/cities.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

Future<void> initialiseApp() async {
  CityDatabase.instance.initialise();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    initializeDateFormatting('en_US');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          opacity: 0.8,
        ),
      ),
      home: const HomePage(),
    );
  }
}

