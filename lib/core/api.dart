import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/constant/network.dart';

import 'utils/token_helper.dart';

class Api {
  late Dio dio;
  CancelToken? dioCancelToken;
  String? baseUrl;

  Api() {
    dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.options.connectTimeout = const Duration(minutes: 6);
    dio.options.extra['withCredentials'] = true;
    dio.options.receiveTimeout = const Duration(minutes: 6);
    dioCancelToken = CancelToken();
    // dio.interceptors.add(
    //   LogInterceptor(
    //     responseBody: true,
    //     requestHeader: true,
    //     responseHeader: true,
    //     request: true,
    //     requestBody: true,
    //   ),
    // );
    baseUrl = NETWORK.baseUrlDevelopment;
    dio.options.headers['Language'] = "EN";
  }

  setToken(String token) {
    dio.options.headers['Authorization'] = "Bearer $token";
    debugPrint('token API : $token');
  }

  clearToken(String token) {
    dio.options.headers['Authorization'] = "";
  }

  final _tokenHelper = TokenHelper();

  Future<Response> get({
    required String path,
    Map<String, String>? queryParameters,
  }) async {
    String token = await _tokenHelper.getToken();

    return dio.get(
      '$baseUrl/$path',
      queryParameters: queryParameters,
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          'Authorization': 'Bearer 1|WokRquFFRK1oMRNpROq07NiYhdKihGr4UQCSv9K0',
        },
      ),
    );
  }

  Future<Response> post({
    required String path,
    FormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
  }) async {
    String token = await _tokenHelper.getToken();

    return dio.post(
      '$baseUrl/$path',
      data: formData ?? formObj,
      queryParameters: queryParameters,
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> put({
    required String path,
    FormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
  }) async {
    String token = await _tokenHelper.getToken();

    return dio.put(
      '$baseUrl/$path',
      data: formData ?? formObj,
      queryParameters: queryParameters,
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> delete({
    required String path,
    FormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
  }) async {
    String token = await _tokenHelper.getToken();

    return dio.delete(
      '$baseUrl/$path',
      data: formData ?? formObj,
      queryParameters: queryParameters,
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
