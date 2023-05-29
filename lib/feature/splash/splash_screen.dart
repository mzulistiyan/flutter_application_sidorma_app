import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/utils/size_config.dart';
import 'package:flutter_application_sidorma/core/utils/token_helper.dart';
import 'package:flutter_application_sidorma/feature/auth/screen/login_screen.dart';
import 'package:flutter_application_sidorma/feature/home/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TokenHelper _tokenHelper = TokenHelper();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      String token = await _tokenHelper.getToken();
      debugPrint('Token Login Splash Screen : $token');
      if (token.isEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: SizeConfig.screenWidth * 0.8,
        child: Image.asset(
          'assets/images/icons/ic_telyu.png',
        ),
      ),
    ));
  }
}
