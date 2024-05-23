// To parse this JSON data, do
//
//     final information = informationFromJson(jsonString);

import 'dart:convert';

Information informationFromJson(String str) =>
    Information.fromJson(json.decode(str));

String informationToJson(Information data) => json.encode(data.toJson());

class Information {
  final int id;
  final String createdAt;
  final String present;
  final String aboutUs;
  final String mision;
  final String vision;
  final List<String> credits;
  final List<String> clients;

  Information({
    required this.id,
    required this.createdAt,
    required this.present,
    required this.aboutUs,
    required this.mision,
    required this.vision,
    required this.credits,
    required this.clients,
  });

  Information copyWith({
    int? id,
    String? createdAt,
    String? present,
    String? aboutUs,
    String? mision,
    String? vision,
    List<String>? credits,
    List<String>? clients,
  }) =>
      Information(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        present: present ?? this.present,
        aboutUs: aboutUs ?? this.aboutUs,
        mision: mision ?? this.mision,
        vision: vision ?? this.vision,
        credits: credits ?? this.credits,
        clients: clients ?? this.clients,
      );

  factory Information.fromJson(Map<String, dynamic> json) => Information(
        id: json["id"],
        createdAt: json["created_at"],
        present: json["present"],
        aboutUs: json["about_us"],
        mision: json["mision"],
        vision: json["vision"],
        credits: List<String>.from(json["credits"].map((x) => x)),
        clients: List<String>.from(json["clients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "present": present,
        "about_us": aboutUs,
        "mision": mision,
        "vision": vision,
        "credits": List<dynamic>.from(credits.map((x) => x)),
        "clients": List<dynamic>.from(clients.map((x) => x)),
      };
}
