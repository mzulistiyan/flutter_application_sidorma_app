import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/constant/network.dart';
import 'package:flutter_application_sidorma/feature/home/screen/home_screen.dart';
import 'package:flutter_application_sidorma/feature/profile_mahasiswa/screen/bantuan_screen.dart';
import 'package:flutter_application_sidorma/feature/splash/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'feature/auth/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('id_ID', null);
//Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("dbafa003-d3a0-42a5-8a8f-f97052043ea2");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
