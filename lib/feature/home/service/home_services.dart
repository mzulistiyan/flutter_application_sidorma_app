import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_report_today.dart';

import '../../../core/utils/token_helper.dart';

class HomeServices {
  var _dio = Dio();
  Future<Response<dynamic>?> absensi({
    File? file,
  }) async {
    String date = DateTime.now().toString();
    try {
      final response = await Api().post(
          path: 'api/absensi',
          formData: file?.path == ''
              ? FormData.fromMap(
                  {
                    "waktu_absensi": date,
                    'image': await MultipartFile.fromFile(file!.path),
                  },
                )
              : FormData.fromMap(
                  {
                    "waktu_absensi": date,
                  },
                ));
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

  Future<Response<dynamic>?> getReportBulanan({
    required String month,
    required String year,
  }) async {
    //token
    final _tokenHelper = TokenHelper();
    try {
      // final response = await Api().get(
      //   path: '/api/report?detailMonth=true',
      // );
      final response = await _dio.get(
        'https://506d-103-156-164-13.ngrok-free.app/api/report?detailMonth=true',
        data: {
          "bulan": month,
          "tahun": year,
        },
        options: Options(
          headers: {'Authorization': 'Bearer 23|mcCpRzuO7CmHJKJxxxfLILGoyZk8yMDkbni10mLZ'},
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }
}
