import 'package:cargo/bottom_nav_bar.dart';
import 'package:cargo/constants.dart';
import 'package:cargo/screens/home/auth_screen.dart';
import 'package:cargo/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Fastgate Cargo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: kPrimaryColor,
              iconTheme: IconThemeData(size: 20, color: Colors.white),
              elevation: 0,
            )),
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        home: const MyNav());
  }
}
