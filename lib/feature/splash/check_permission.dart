import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_sidorma/feature/auth/screen/login_screen.dart';
import 'package:flutter_radar/flutter_radar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/resources/colors.dart';
import '../../core/resources/fonts.dart';
import '../../core/utils/size_config.dart';
import '../../core/widget/custom_separator.dart';

class ChecKPermissionScreen extends StatefulWidget {
  const ChecKPermissionScreen({super.key});

  @override
  State<ChecKPermissionScreen> createState() => _ChecKPermissionScreenState();
}

class _ChecKPermissionScreenState extends State<ChecKPermissionScreen> {
  PermissionStatus _permissionStatusLocation = PermissionStatus.denied;
  TargetPlatform? platform;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {});
    _checkPermissionStatusLocation();
  }

  Future<void> _checkPermissionStatusLocation() async {
    PermissionStatus status = await Permission.location.status;
    setState(() {
      _permissionStatusLocation = status;
    });
  }

  bool get _isPermissionGrantedLocation {
    return _permissionStatusLocation.isGranted;
  }

  bool get _isPermissionDeniedLocation {
    return _permissionStatusLocation.isDenied || _permissionStatusLocation.isPermanentlyDenied;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ColorsGlobal.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/illustrations/il_permission_location.png'),
              Text('Allow Your Location', style: FontsGlobal.boldTextStyle18),
              const VerticalSeparator(height: 2),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                textAlign: TextAlign.center,
                style: FontsGlobal.regulerTextStyle12.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(14),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.05,
        decoration: BoxDecoration(
          color: ColorsGlobal.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () async {
            if (_isPermissionDeniedLocation) {
              PermissionStatus status = await Permission.location.request();
              setState(() {
                _permissionStatusLocation = status;
              });
              if (_permissionStatusLocation.isGranted) {
                debugPrint('Permission Granted');
              }
            } else {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
            }
          },
          child: Text(
            _isPermissionGrantedLocation ? 'Next' : 'Sure, I\'d like that',
            style: FontsGlobal.boldTextStyle10.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
