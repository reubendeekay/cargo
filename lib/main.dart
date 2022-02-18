import 'package:cargo/bottom_nav_bar.dart';
import 'package:cargo/constants.dart';
import 'package:cargo/firebase_options.dart';
import 'package:cargo/providers/auth_provider.dart';

import 'package:cargo/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
      ],
      child: GetMaterialApp(
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
          home: const SplashScreen()),
    );
  }
}
