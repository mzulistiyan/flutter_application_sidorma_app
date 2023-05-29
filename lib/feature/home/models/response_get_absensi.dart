// To parse this JSON data, do
//
//     final responseStatusAbsensi = responseStatusAbsensiFromJson(jsonString);

import 'dart:convert';

ResponseStatusAbsensi responseStatusAbsensiFromJson(String str) => ResponseStatusAbsensi.fromJson(json.decode(str));

String responseStatusAbsensiToJson(ResponseStatusAbsensi data) => json.encode(data.toJson());

class ResponseStatusAbsensi {
  Meta meta;
  Data data;

  ResponseStatusAbsensi({
    required this.meta,
    required this.data,
  });

  factory ResponseStatusAbsensi.fromJson(Map<String, dynamic> json) => ResponseStatusAbsensi(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  bool status;

  Data({
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class Meta {
  int code;
  String status;
  String message;

  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}
