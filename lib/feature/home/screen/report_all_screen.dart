import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_bulanan.dart';
import 'package:flutter_application_sidorma/feature/home/screen/widget_report_card.dart';
import 'package:flutter_application_sidorma/feature/profile_walisiswa/screen/profile_wali_siswa_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/resources/colors.dart';
import '../../../core/resources/fonts.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widget/custom_separator.dart';
import '../bloc/bloc/report_bulanan_bloc.dart';
import '../bloc/handle_api/get_report_today_bloc.dart';
import '../models/response_get_report_today.dart';

class ReportAllScreen extends StatefulWidget {
  const ReportAllScreen({super.key});

  @override
  State<ReportAllScreen> createState() => _ReportAllScreenState();
}

class _ReportAllScreenState extends State<ReportAllScreen> {
  final _reportBulanan = ReportBulananBloc();
  bool showCardAbsensiReport = false;
  DateTime _selectedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  dynamic _pickerOpen = false;
  bool pickerIsExpanded = false;
  int _pickerYear = DateTime.now().year;
  void switchPicker() {
    setState(() {
      _pickerOpen ^= true;
    });
  }

  Material monthAndYearPickerWIdget(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: AnimatedSize(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: _pickerOpen ? null : 0.0,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _pickerYear = _pickerYear - 1;
                      });
                    },
                    icon: const Icon(Icons.navigate_before_rounded),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        _pickerYear.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _pickerYear = _pickerYear + 1;
                      });
                    },
                    icon: const Icon(Icons.navigate_next_rounded),
                  ),
                ],
              ),
              ...generateMonths(),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateRowOfMonths(from, to) {
    List<Widget> months = [];
    for (int i = from; i <= to; i++) {
      DateTime dateTime = DateTime(_pickerYear, i, 1);
      final backgroundColor = dateTime.isAtSameMomentAs(_selectedMonth) ? ColorsGlobal.secondaryColor : Colors.transparent;
      months.add(
        AnimatedSwitcher(
          duration: kThemeChangeDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: TextButton(
            key: ValueKey(backgroundColor),
            onPressed: () {
              setState(() {
                _selectedMonth = dateTime;
              });

              _reportBulanan.add(GetReportBulanan(
                bulan: _selectedMonth.month.toString(),
                tahun: _selectedMonth.year.toString(),
              ));
              debugPrint('Selected Month: ${_selectedMonth.month}');
              debugPrint('Selected Year: ${_selectedMonth.year}');
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: const CircleBorder(),
            ),
            child: Text(
              DateFormat('MMM').format(dateTime),
              style: GoogleFonts.poppins(
                color: _selectedMonth.month == dateTime.month && _selectedMonth.year == dateTime.year ? ColorsGlobal.whiteColor : ColorsGlobal.blackColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    return months;
  }

  List<Widget> generateMonths() {
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateRowOfMonths(1, 6),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateRowOfMonths(7, 12),
        ),
      ),
    ];
  }

  @override
  void initState() {
    _reportBulanan.add(GetReportBulanan(
      bulan: _selectedMonth.month.toString(),
      tahun: _selectedMonth.year.toString(),
    ));
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
          'Report Bulanan',
          style: FontsGlobal.semiBoldTextStyle14.copyWith(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              switchPicker();
            },
            icon: const Icon(
              Icons.filter_list_outlined,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          monthAndYearPickerWIdget(context),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<ReportBulananBloc, ReportBulananState>(
                  bloc: _reportBulanan,
                  listener: (context, state) {
                    debugPrint('State Report Today : $state');
                  },
                  builder: (context, state) {
                    if (state is ReportBulananLoading) {
                    } else if (state is ReportBulananSuccess) {
                      return Column(
                        children: List.generate(state.responseGetReportBulanan.data.length, (index) {
                          if (state.responseGetReportBulanan.data[index].isNotEmpty) {
                            return MyWidgetAbsensi(
                              context: context,
                              showCardAbsensiReport: showCardAbsensiReport,
                              dataResponseAbsensiBulanan: state.responseGetReportBulanan.data[index][0],
                              indexDatumLength: state.responseGetReportBulanan.data[index].length,
                              listDatum: state.responseGetReportBulanan.data[index],
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                      );
                    } else if (state is GetReportTodayError) {
                      return ElevatedButton(onPressed: () {}, child: const Text('Reload'));
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

  Widget cardHadirByStatusSistem(BuildContext contex, Datum dataAbsensiToday) {
    DateTime date = dataAbsensiToday.createdAt;
    DateTime? clockIn = dataAbsensiToday.clockIn;

    DateTime? clockOut = dataAbsensiToday.clockOut;

    String formattedTimeClockIn = clockIn == null ? " " : DateFormat('HH:mm').format(clockIn);
    String formattedTimeClockOut = DateFormat('HH:mm').format(clockOut!);

    String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
    return Container(
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
