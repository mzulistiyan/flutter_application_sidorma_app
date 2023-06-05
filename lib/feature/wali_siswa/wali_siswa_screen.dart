import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_sidorma/feature/profile_walisiswa/screen/profile_wali_siswa_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/resources/colors.dart';
import '../../core/resources/fonts.dart';
import '../../core/utils/size_config.dart';
import '../../core/widget/custom_separator.dart';
import '../home/bloc/bloc/get_report_today_bloc.dart';
import '../home/models/response_get_report_today.dart';

class WaliSiswaScreen extends StatefulWidget {
  const WaliSiswaScreen({super.key});

  @override
  State<WaliSiswaScreen> createState() => _WaliSiswaScreenState();
}

class _WaliSiswaScreenState extends State<WaliSiswaScreen> {
  final _reportTodayBloc = GetReportTodayBloc();
  @override
  void initState() {
    _reportTodayBloc.add(GetReportToday());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.

        title: Text(
          'Log Mahasiswa Hari Ini',
          style: FontsGlobal.semiBoldTextStyle14.copyWith(color: Colors.black),
        ),
        actions: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const MenuPage(),
                  //   ),
                  // );
                  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
                  //   print("Accepted permission: $accepted");
                  // });

                  // //check whether the app is subscribed to onesignal****
                  // OneSignal.shared.getDeviceState().then((deviceState) async {
                  //   if (deviceState?.subscribed == true) {
                  //     await OneSignal.shared.setExternalUserId("0000112233333");
                  //   }
                  // });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileWaliSiswaScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.person, color: Colors.black),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<GetReportTodayBloc, GetReportTodayState>(
                  bloc: _reportTodayBloc,
                  listener: (context, state) {
                    debugPrint('State Report Today : $state');
                  },
                  builder: (context, state) {
                    if (state is GetReportTodayLoading) {
                    } else if (state is GetReportTodaySuccess) {
                      return Column(
                        children: List.generate(
                          state.responseGetReportToday.data.length,
                          (index) => cardHadirByStatusSistem(context, state.responseGetReportToday.data[index]),
                        ),
                      );
                    } else if (state is GetReportTodayError) {
                      return ElevatedButton(
                          onPressed: () {
                            _reportTodayBloc.add(GetReportToday());
                          },
                          child: const Text('Reload'));
                    }
                    return const SizedBox();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cardHadirByStatusSistem(BuildContext contex, DataAbsensiToday dataAbsensiToday) {
    DateTime date = dataAbsensiToday.createdAt;
    DateTime? clockIn = dataAbsensiToday.clockIn;

    DateTime clockOut = dataAbsensiToday.clockOut;

    String formattedTimeClockIn = clockIn == null ? " " : DateFormat('HH:mm').format(clockIn);
    String formattedTimeClockOut = DateFormat('HH:mm').format(clockOut);

    String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsGlobal.greyColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icons/ic_card_report_absen.png',
                        width: 32,
                      ),
                      const HorizontalSeparator(width: 2),
                      Container(
                        // color: Colors.amber,
                        width: SizeConfig.screenWidth * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedDate,
                              style: FontsGlobal.mediumTextStyle12,
                            ),
                            const VerticalSeparator(height: 0.2),
                            Text(
                              '$formattedTimeClockOut - $formattedTimeClockIn',
                              style: FontsGlobal.regulerTextStyle10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const HorizontalSeparator(width: 2),
                  Flexible(
                    child: Container(
                      // color: Colors.amber,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: SizeConfig.screenHeight * 0.02,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: dataAbsensiToday.status == true ? ColorsGlobal.secondaryColor : Colors.green,
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              dataAbsensiToday.status == true ? "Keluar".toUpperCase() : 'Selesai'.toUpperCase(),
                              style: FontsGlobal.semiBoldTextStyle8.copyWith(
                                color: dataAbsensiToday.status == true ? ColorsGlobal.secondaryColor : Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
