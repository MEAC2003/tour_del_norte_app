// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

List<Car> carFromJson(String str) =>
    List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
  final int id;
  final String createdAt;
  final String name;
  final String shortOverview;
  final int passengers;
  final String mileage;
  final int priceByDay;
  final List<String> images;
  final String fullOverview;
  final bool isAvailable;
  final int idCarModel;
  final int doors;
  final String type;
  final String fuelType;

  Car({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.shortOverview,
    required this.passengers,
    required this.mileage,
    required this.priceByDay,
    required this.images,
    required this.fullOverview,
    required this.isAvailable,
    required this.idCarModel,
    required this.doors,
    required this.type,
    required this.fuelType,
  });

  Car copyWith({
    int? id,
    String? createdAt,
    String? name,
    String? shortOverview,
    int? passengers,
    String? mileage,
    int? priceByDay,
    List<String>? images,
    String? fullOverview,
    bool? isAvailable,
    int? idCarModel,
    int? doors,
    String? type,
    String? fuelType,
  }) =>
      Car(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        shortOverview: shortOverview ?? this.shortOverview,
        passengers: passengers ?? this.passengers,
        mileage: mileage ?? this.mileage,
        priceByDay: priceByDay ?? this.priceByDay,
        images: images ?? this.images,
        fullOverview: fullOverview ?? this.fullOverview,
        isAvailable: isAvailable ?? this.isAvailable,
        idCarModel: idCarModel ?? this.idCarModel,
        doors: doors ?? this.doors,
        type: type ?? this.type,
        fuelType: fuelType ?? this.fuelType,
      );

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
        shortOverview: json["short_overview"],
        passengers: json["passengers"],
        mileage: json["mileage"],
        priceByDay: json["price_by_day"],
        images: List<String>.from(json["images"].map((x) => x)),
        fullOverview: json["full_overview"],
        isAvailable: json["is_available"],
        idCarModel: json["id_car_model"],
        doors: json["doors"],
        type: json["type"],
        fuelType: json["fuel_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "name": name,
        "short_overview": shortOverview,
        "passengers": passengers,
        "mileage": mileage,
        "price_by_day": priceByDay,
        "images": List<dynamic>.from(images.map((x) => x)),
        "full_overview": fullOverview,
        "is_available": isAvailable,
        "id_car_model": idCarModel,
        "doors": doors,
        "type": type,
        "fuel_type": fuelType,
      };
}
