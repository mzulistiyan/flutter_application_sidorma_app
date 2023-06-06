// To parse this JSON data, do
//
//     final responseGetBulananAbsen = responseGetBulananAbsenFromJson(jsonString);

import 'dart:convert';

ResponseGetBulananAbsen responseGetBulananAbsenFromJson(String str) => ResponseGetBulananAbsen.fromJson(json.decode(str));

String responseGetBulananAbsenToJson(ResponseGetBulananAbsen data) => json.encode(data.toJson());

class ResponseGetBulananAbsen {
  Meta meta;
  List<List<Datum>> data;

  ResponseGetBulananAbsen({
    required this.meta,
    required this.data,
  });

  factory ResponseGetBulananAbsen.fromJson(Map<String, dynamic> json) => ResponseGetBulananAbsen(
        meta: Meta.fromJson(json["meta"]),
        data: List<List<Datum>>.from(json["data"].map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Datum {
  int idAbsensi;
  String nimMahasiswa;
  DateTime? clockIn;
  DateTime? clockOut;
  bool status;
  String? photo;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.idAbsensi,
    required this.nimMahasiswa,
    required this.clockIn,
    required this.clockOut,
    required this.status,
    this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idAbsensi: json["id_absensi"],
        nimMahasiswa: json["nim_mahasiswa"],
        clockIn: DateTime.parse(json["clock_in"]),
        clockOut: DateTime.parse(json["clock_out"]),
        status: json["status"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "nim_mahasiswa": nimMahasiswa,
        "clock_in": clockIn,
        "clock_out": clockOut,
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
