// To parse this JSON data, do
//
//     final carBrand = carBrandFromJson(jsonString);

import 'dart:convert';

List<CarBrand> carBrandFromJson(String str) =>
    List<CarBrand>.from(json.decode(str).map((x) => CarBrand.fromJson(x)));

String carBrandToJson(List<CarBrand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarBrand {
  final int id;
  final String createdAt;
  final String name;

  CarBrand({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  CarBrand copyWith({
    int? id,
    String? createdAt,
    String? name,
  }) =>
      CarBrand(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );

  factory CarBrand.fromJson(Map<String, dynamic> json) => CarBrand(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "name": name,
      };
}
