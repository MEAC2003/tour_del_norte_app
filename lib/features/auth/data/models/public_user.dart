// To parse this JSON data, do
//
//     final publicUser = publicUserFromJson(jsonString);

import 'dart:convert';

List<PublicUser> publicUserFromJson(String str) =>
    List<PublicUser>.from(json.decode(str).map((x) => PublicUser.fromJson(x)));

String publicUserToJson(List<PublicUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicUser {
  String id;
  String createdAt;
  String email;
  String fullName;
  String phone;
  String dni;
  List<String>? license;
  String role;

  PublicUser({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.dni,
    required this.license,
    required this.role,
  });

  PublicUser copyWith({
    String? id,
    String? createdAt,
    String? email,
    String? fullName,
    String? phone,
    String? dni,
    List<String>? license,
    String? role,
  }) =>
      PublicUser(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        dni: dni ?? this.dni,
        license: license ?? this.license,
        role: role ?? this.role,
      );

  factory PublicUser.fromJson(Map<String, dynamic> json) => PublicUser(
        id: json["id"],
        createdAt: json["created_at"],
        email: json["email"],
        fullName: json["full_name"],
        phone: json["phone"],
        dni: json["dni"],
        license: json["license"] == null
            ? []
            : List<String>.from(json["license"]!.map((x) => x)),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "email": email,
        "full_name": fullName,
        "phone": phone,
        "dni": dni,
        "license":
            license == null ? [] : List<dynamic>.from(license!.map((x) => x)),
        "role": role,
      };
}
