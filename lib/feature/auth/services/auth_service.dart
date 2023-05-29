import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';

class AuthService {
  final Dio _dio = Dio();
  int limit = 1000;

  Future<Response<dynamic>?> login({
    String? email,
    String? passsword,
  }) async {
    try {
      final response = await Api().post(
        path: 'api/login',
        formObj: {
          "email": email!,
          "password": passsword!,
        },
      );
      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }
}
