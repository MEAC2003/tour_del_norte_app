// To parse this JSON data, do
//
//     final information = informationFromJson(jsonString);

import 'dart:convert';

Information informationFromJson(String str) =>
    Information.fromJson(json.decode(str));

String informationToJson(Information data) => json.encode(data.toJson());

class Information {
  final int? id;
  final String? createdAt;
  final String? present;
  final String? aboutUs;
  final String? mision;
  final String? vision;
  final List<String>? credits;
  final List<String>? clients;

  Information({
    this.id,
    this.createdAt,
    this.present,
    this.aboutUs,
    this.mision,
    this.vision,
    this.credits,
    this.clients,
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
        credits: json["credits"] != null
            ? List<String>.from(json["credits"].map((x) => x))
            : null,
        clients: json["clients"] != null
            ? List<String>.from(json["clients"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "present": present,
        "about_us": aboutUs,
        "mision": mision,
        "vision": vision,
        "credits":
            credits != null ? List<dynamic>.from(credits!.map((x) => x)) : null,
        "clients":
            clients != null ? List<dynamic>.from(clients!.map((x) => x)) : null,
      };
}
