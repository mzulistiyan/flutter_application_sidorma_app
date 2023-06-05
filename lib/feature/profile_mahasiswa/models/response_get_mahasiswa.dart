// To parse this JSON data, do
//
//     final responseGetMahasiswa = responseGetMahasiswaFromJson(jsonString);

import 'dart:convert';

ResponseGetMahasiswa responseGetMahasiswaFromJson(String str) => ResponseGetMahasiswa.fromJson(json.decode(str));

String responseGetMahasiswaToJson(ResponseGetMahasiswa data) => json.encode(data.toJson());

class ResponseGetMahasiswa {
  Meta meta;
  DataGetMahasiswa data;

  ResponseGetMahasiswa({
    required this.meta,
    required this.data,
  });

  factory ResponseGetMahasiswa.fromJson(Map<String, dynamic> json) => ResponseGetMahasiswa(
        meta: Meta.fromJson(json["meta"]),
        data: DataGetMahasiswa.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class DataGetMahasiswa {
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

  DataGetMahasiswa({
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

  factory DataGetMahasiswa.fromJson(Map<String, dynamic> json) => DataGetMahasiswa(
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
  int id;
  String name;
  int nim;
  String fakultas;
  String prodi;
  String alamat;
  String noTelp;
  String idGedung;
  DateTime createdAt;
  DateTime updatedAt;

  Detail({
    required this.id,
    required this.name,
    required this.nim,
    required this.fakultas,
    required this.prodi,
    required this.alamat,
    required this.noTelp,
    required this.idGedung,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        nim: json["nim"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
        idGedung: json["id_gedung"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nim": nim,
        "fakultas": fakultas,
        "prodi": prodi,
        "alamat": alamat,
        "no_telp": noTelp,
        "id_gedung": idGedung,
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
