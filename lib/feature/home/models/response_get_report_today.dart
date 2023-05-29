// To parse this JSON data, do
//
//     final responseGetReportToday = responseGetReportTodayFromJson(jsonString);

import 'dart:convert';

ResponseGetReportToday responseGetReportTodayFromJson(String str) => ResponseGetReportToday.fromJson(json.decode(str));

String responseGetReportTodayToJson(ResponseGetReportToday data) => json.encode(data.toJson());

class ResponseGetReportToday {
  Meta meta;
  List<DataAbsensiToday> data;

  ResponseGetReportToday({
    required this.meta,
    required this.data,
  });

  factory ResponseGetReportToday.fromJson(Map<String, dynamic> json) => ResponseGetReportToday(
        meta: Meta.fromJson(json["meta"]),
        data: List<DataAbsensiToday>.from(json["data"].map((x) => DataAbsensiToday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataAbsensiToday {
  int idAbsensi;
  String nimMahasiswa;
  DateTime? clockIn;
  DateTime clockOut;
  bool status;
  dynamic photo;
  DateTime createdAt;
  DateTime updatedAt;

  DataAbsensiToday({
    required this.idAbsensi,
    required this.nimMahasiswa,
    this.clockIn,
    required this.clockOut,
    required this.status,
    this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataAbsensiToday.fromJson(Map<String, dynamic> json) => DataAbsensiToday(
        idAbsensi: json["id_absensi"],
        nimMahasiswa: json["nim_mahasiswa"],
        clockIn: json["clock_in"] == null ? null : DateTime.parse(json["clock_in"]),
        clockOut: DateTime.parse(json["clock_out"]),
        status: json["status"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "nim_mahasiswa": nimMahasiswa,
        "clock_in": "${clockIn!.year.toString().padLeft(4, '0')}-${clockIn!.month.toString().padLeft(2, '0')}-${clockIn!.day.toString().padLeft(2, '0')}",
        "clock_out": "${clockOut.year.toString().padLeft(4, '0')}-${clockOut.month.toString().padLeft(2, '0')}-${clockOut.day.toString().padLeft(2, '0')}",
        "status": status,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
