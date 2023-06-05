// To parse this JSON data, do
//
//     final responseGetWaliMahasiswa = responseGetWaliMahasiswaFromJson(jsonString);

import 'dart:convert';

ResponseGetWaliMahasiswa responseGetWaliMahasiswaFromJson(String str) => ResponseGetWaliMahasiswa.fromJson(json.decode(str));

String responseGetWaliMahasiswaToJson(ResponseGetWaliMahasiswa data) => json.encode(data.toJson());

class ResponseGetWaliMahasiswa {
  Meta meta;
  DataGetWaliMahasiswa data;

  ResponseGetWaliMahasiswa({
    required this.meta,
    required this.data,
  });

  factory ResponseGetWaliMahasiswa.fromJson(Map<String, dynamic> json) => ResponseGetWaliMahasiswa(
        meta: Meta.fromJson(json["meta"]),
        data: DataGetWaliMahasiswa.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class DataGetWaliMahasiswa {
  int id;
  String nim;
  String email;
  dynamic emailVerifiedAt;
  String role;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  Detail detail;
  String profilePhotoUrl;

  DataGetWaliMahasiswa({
    required this.id,
    required this.nim,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    this.twoFactorConfirmedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.detail,
    required this.profilePhotoUrl,
  });

  factory DataGetWaliMahasiswa.fromJson(Map<String, dynamic> json) => DataGetWaliMahasiswa(
        id: json["id"],
        nim: json["nim"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        detail: Detail.fromJson(json["detail"]),
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nim": nim,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "detail": detail.toJson(),
        "profile_photo_url": profilePhotoUrl,
      };
}

class Detail {
  int idWali;
  String nama;
  String noTelp;
  String nim;
  String alamat;
  String hubungan;
  DateTime createdAt;
  DateTime updatedAt;

  Detail({
    required this.idWali,
    required this.nama,
    required this.noTelp,
    required this.nim,
    required this.alamat,
    required this.hubungan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        idWali: json["id_wali"],
        nama: json["nama"],
        noTelp: json["no_telp"],
        nim: json["nim"],
        alamat: json["alamat"],
        hubungan: json["hubungan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_wali": idWali,
        "nama": nama,
        "no_telp": noTelp,
        "nim": nim,
        "alamat": alamat,
        "hubungan": hubungan,
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
