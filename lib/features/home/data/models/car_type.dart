// To parse this JSON data, do
//
//     final carType = carTypeFromJson(jsonString);

import 'dart:convert';

List<CarType> carTypeFromJson(String str) =>
    List<CarType>.from(json.decode(str).map((x) => CarType.fromJson(x)));

String carTypeToJson(List<CarType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarType {
  int id;
  String createdAt;
  String typeName;

  CarType({
    required this.id,
    required this.createdAt,
    required this.typeName,
  });

  CarType copyWith({
    int? id,
    String? createdAt,
    String? typeName,
  }) =>
      CarType(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        typeName: typeName ?? this.typeName,
      );

  factory CarType.fromJson(Map<String, dynamic> json) => CarType(
        id: json["id"],
        createdAt: json["created_at"],
        typeName: json["type_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "type_name": typeName,
      };
}
