import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_report_today.dart';

class HomeServices {
  Future<Response<dynamic>?> absensi() async {
    String date = DateTime.now().toString();
    try {
      final response = await Api().post(
        path: 'api/absensi',
        formObj: {
          "waktu_absensi": date,
        },
      );
      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> getAbsensi() async {
    try {
      final response = await Api().get(
        path: 'api/status',
      );
      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> getReportHarian() async {
    try {
      final response = await Api().get(
        path: 'api/report?today=true',
      );
      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<DataAbsensiToday> getReportToday() async {
    final response = await Api().get(
      path: 'api/report?today=true',
    );
    if (response.statusCode == 200) {
      debugPrint("testing 200");
      var data = jsonDecode(response.data);
      var parsed = data['data'] as Map<String, dynamic>;
      return DataAbsensiToday.fromJson(parsed);
    } else {
      throw Exception('Failed to load mahasiswa');
    }
  }
}
