import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_report_today.dart';

Future<List<DataAbsensiToday>> getReportToday() async {
  final response = await Api().get(
    path: 'api/report?today=true',
  );
  if (response.statusCode == 200) {
    debugPrint("testing 200");
    var data = jsonDecode(response.data);
    debugPrint("Data Testing : $data");
    var parsed = data['data'].cast<Map<String, dynamic>>();
    return parsed
        .map<DataAbsensiToday>((json) => DataAbsensiToday.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load mahasiswa');
  }
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late Future<List<DataAbsensiToday>> futureReport;

  @override
  void initState() {
    super.initState();
    futureReport = getReportToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DataAbsensiToday>>(
        future: futureReport,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DataAbsensiToday>? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(data[index].nimMahasiswa),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        // padding: const EdgeInsets.all(24),
        // children: [
        //   Container(
        //       padding: const EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         border: Border.all(),
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Column(
        //             children: [
        //               Row(
        //                 children: [
        //                   Image.asset(
        //                     'assets/images/icons/ic_card_report_absen.png',
        //                     width: 32,
        //                   ),
        //                   const SizedBox(
        //                     width: 20,
        //                   ),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: const [Text("Minggu"), Text('data')],
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //           Container(
        //             width: 50,
        //             height: 25,
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey),
        //                 color: Colors.green),
        //             child: const Center(
        //               child: Text('pp'),
        //             ),
        //           ),
        //         ],
        //       )),
        // ],
      ),
    );
  }
}
