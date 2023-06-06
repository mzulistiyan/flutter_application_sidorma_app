import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/constant/network.dart';
import 'package:flutter_application_sidorma/feature/home/screen/home_screen.dart';
import 'package:flutter_application_sidorma/feature/profile_walisiswa/screen/report_wali_siswa_screen.dart';
import 'package:flutter_application_sidorma/feature/splash/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/utils/token_helper.dart';
import 'feature/auth/screen/login_screen.dart';
import 'feature/profile_mahasiswa/screen/term_service_screen.dart';
import 'feature/splash/check_permission.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('id_ID', null);
//Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("dbafa003-d3a0-42a5-8a8f-f97052043ea2");

  final _secureStorage = TokenHelper();
  bool statusGranted = false;

  PermissionStatus status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    statusGranted = true;
  }
  bool isLogin = await _secureStorage.containsKey(key: _secureStorage.keyAccessToken);
  bool isMahasiswa = await _secureStorage.getRole() == _secureStorage.role;
  debugPrint('isLogin: $isLogin');
  debugPrint('statusGranted: $statusGranted');
  runApp(MyApp(
    isLogin: isLogin,
    locationAllowed: statusGranted,
    isMahasiswa: isMahasiswa,
  ));
}

class MyApp extends StatelessWidget {
  final bool _isLogin;
  final bool _locationAllowed;
  final bool _isMahasiswa;
  const MyApp({
    super.key,
    bool isLogin = false,
    bool locationAllowed = false,
    bool isMahasiswa = false,
  })  : _isLogin = isLogin,
        _locationAllowed = locationAllowed,
        _isMahasiswa = isMahasiswa;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _locationAllowed
          ? _isLogin
              ? _isMahasiswa
                  ? const HomeScreen()
                  : const ReportWaliSiswaScreen()
              : const LoginScreen()
          : const ChecKPermissionScreen(),
    );
  }
}
