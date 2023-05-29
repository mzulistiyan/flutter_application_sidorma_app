// To parse this JSON data, do
//
//     final responseError = responseErrorFromJson(jsonString);

import 'dart:convert';

ResponseError responseErrorFromJson(String str) => ResponseError.fromJson(json.decode(str));

String responseErrorToJson(ResponseError data) => json.encode(data.toJson());

class ResponseError {
  ResponseError({
    required this.statusCode,
    required this.status,
    required this.message,
  });

  int statusCode;
  bool status;
  String message;

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
        statusCode: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": status,
        "message": message,
      };
}
