// To parse this JSON data, do
//
//     final publicUser = publicUserFromJson(jsonString);

import 'dart:convert';

PublicUser publicUserFromJson(String str) =>
    PublicUser.fromJson(json.decode(str));

String publicUserToJson(PublicUser data) => json.encode(data.toJson());

class PublicUser {
  final String id;
  final String createdAt;
  final String email;
  final String fullName;
  final String phone;
  final String dni;
  final String license;

  PublicUser({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.dni,
    required this.license,
  });

  PublicUser copyWith({
    String? id,
    String? createdAt,
    String? email,
    String? fullName,
    String? phone,
    String? dni,
    String? license,
  }) =>
      PublicUser(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        dni: dni ?? this.dni,
        license: license ?? this.license,
      );

  factory PublicUser.fromJson(Map<String, dynamic> json) => PublicUser(
        id: json["id"],
        createdAt: json["created_at"],
        email: json["email"],
        fullName: json["full_name"],
        phone: json["phone"],
        dni: json["dni"],
        license: json["license"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "email": email,
        "full_name": fullName,
        "phone": phone,
        "dni": dni,
        "license": license,
      };
}
