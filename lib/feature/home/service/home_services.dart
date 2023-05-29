import 'package:dio/dio.dart';
import 'package:flutter_application_sidorma/core/api.dart';

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
}
