import 'package:flutter/material.dart';
import 'package:flutter_application_1/download_manager_page.dart';
// import 'package:flutter_application_1/counter_page.dart';
// import 'package:flutter_application_1/calculator.dart';
import 'package:flutter_application_1/game_page.dart';
// import 'package:flutter_application_1/home_page.dart';
// import 'package:flutter_application_1/splash_page.dart';
import 'package:flutter_application_1/suduku_page.dart';

import 'package:flutter_application_1/async_demo_page.dart';

void main() {
  runApp(
    MaterialApp(
      // home: SplashPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => DownloadManagerPage(),
        // "/": (context) => ContactsPage(),
        "/game": (context) => GamePage(),
        "/suduku": (context) => SudukuPage(),
      },
    ),
  );
}
