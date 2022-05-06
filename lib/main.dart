import 'package:cargo/firebase_options.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/providers/branch_provider.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/providers/location_provider.dart';
import 'package:cargo/providers/notifications_provider.dart';
import 'package:cargo/theme/AppSplashScreen.dart';
import 'package:cargo/theme/app_theme.dart';

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
        ChangeNotifierProvider.value(value: LocationProvider()),
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: CargoProvider()),
        ChangeNotifierProvider.value(value: BranchProvider()),
        ChangeNotifierProvider.value(value: NotificationsProvider()),
      ],
      child: GetMaterialApp(
          title: 'Fastgate Cargo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.learningTheme,
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          home: const AppSplashScreen()),
    );
  }
}
