// To parse this JSON data, do
//
//     final responseAbsensi = responseAbsensiFromJson(jsonString);

import 'dart:convert';

ResponseAbsensi responseAbsensiFromJson(String str) => ResponseAbsensi.fromJson(json.decode(str));

String responseAbsensiToJson(ResponseAbsensi data) => json.encode(data.toJson());

class ResponseAbsensi {
  Meta meta;
  Data data;

  ResponseAbsensi({
    required this.meta,
    required this.data,
  });

  factory ResponseAbsensi.fromJson(Map<String, dynamic> json) => ResponseAbsensi(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  int idAbsensi;
  String nimMahasiswa;
  dynamic clockIn;
  DateTime clockOut;
  bool status;
  dynamic photo;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.idAbsensi,
    required this.nimMahasiswa,
    this.clockIn,
    required this.clockOut,
    required this.status,
    this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idAbsensi: json["id_absensi"],
        nimMahasiswa: json["nim_mahasiswa"],
        clockIn: json["clock_in"],
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
        "clock_out": clockOut.toIso8601String(),
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
