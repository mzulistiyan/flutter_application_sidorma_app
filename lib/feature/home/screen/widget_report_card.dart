import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../../../core/resources/colors.dart';
import '../../../core/resources/fonts.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widget/custom_separator.dart';
import '../models/response_get_bulanan.dart';

class MyWidgetAbsensi extends StatefulWidget {
  BuildContext context;
  bool showCardAbsensiReport;
  Datum dataResponseAbsensiBulanan;
  List<Datum> listDatum;
  int indexDatumLength;

  MyWidgetAbsensi(
      {super.key, required this.context, required this.showCardAbsensiReport, required this.dataResponseAbsensiBulanan, required this.indexDatumLength, required this.listDatum});

  @override
  State<MyWidgetAbsensi> createState() => _MyWidgetAbsensiState();
}

class _MyWidgetAbsensiState extends State<MyWidgetAbsensi> {
  @override
  Widget build(BuildContext context) {
    return card(context);
  }

  GestureDetector card(BuildContext context) {
    DateTime date = widget.dataResponseAbsensiBulanan.createdAt;
    String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.showCardAbsensiReport = !widget.showCardAbsensiReport;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
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
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/icons/ic_card_report_absen.png',
                            width: SizeConfig.screenWidth * 0.085,
                          ),
                          const HorizontalSeparator(width: 1),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate,
                                  style: FontsGlobal.mediumTextStyle12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.showCardAbsensiReport
                ? Column(
                    children: [
                      const VerticalSeparator(height: 1),
                      Divider(
                        color: ColorsGlobal.greyColor,
                      ),
                    ],
                  )
                : const SizedBox(),
            widget.showCardAbsensiReport
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data Harian', style: FontsGlobal.semiBoldTextStyle12),
                        const VerticalSeparator(height: 1),
                        Column(
                          children: List.generate(
                            widget.indexDatumLength,
                            (index) => cardHadirByStatusSistem(context, widget.listDatum, index),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget cardHadirByStatusSistem(BuildContext contex, List<Datum> dataAbsensiToday, int indexData) {
    DateTime date = dataAbsensiToday[indexData].createdAt;
    DateTime? clockIn = dataAbsensiToday[indexData].clockIn;

    DateTime? clockOut = dataAbsensiToday[indexData].clockOut == null ? DateTime.now() : dataAbsensiToday[indexData].clockOut!;

    String formattedTimeClockIn = clockIn == null ? " " : DateFormat('HH:mm').format(clockIn);
    String formattedTimeClockOut = clockOut == null ? " " : DateFormat('HH:mm').format(clockOut);

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
                      Container(
                        // color: Colors.amber,
                        width: SizeConfig.screenWidth * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jam Keluar : $formattedTimeClockOut",
                              style: FontsGlobal.regulerTextStyle10,
                            ),
                            Text(
                              'Jam Masuk : $formattedTimeClockIn',
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
                              color: dataAbsensiToday[indexData].status == true ? ColorsGlobal.secondaryColor : Colors.green,
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              dataAbsensiToday[indexData].status == true ? "Keluar".toUpperCase() : 'Selesai'.toUpperCase(),
                              style: FontsGlobal.semiBoldTextStyle8.copyWith(
                                color: dataAbsensiToday[indexData].status == true ? ColorsGlobal.secondaryColor : Colors.green,
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
