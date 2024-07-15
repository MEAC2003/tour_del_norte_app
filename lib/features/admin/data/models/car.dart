// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

List<Car> carFromJson(String str) =>
    List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
  int? id;
  String? createdAt;
  String? name;
  String? shortOverview;
  int? passengers;
  String? mileage;
  int? priceByDay;
  List<String>? images;
  String? fullOverview;
  bool? isAvailable;
  int? idCarModel;
  int? doors;
  String? type;
  String? fuelType;
  String? year;
  int? idCarType;
  Car({
    this.id,
    this.createdAt,
    this.name,
    this.shortOverview,
    this.passengers,
    this.mileage,
    this.priceByDay,
    this.images,
    this.fullOverview,
    this.isAvailable,
    this.idCarModel,
    this.doors,
    this.type,
    this.fuelType,
    this.year,
    this.idCarType,
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
    String? year,
    int? idCarType,
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
        year: year ?? this.year,
        idCarType: idCarType ?? this.idCarType,
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
        year: json["year"],
        idCarType: json["id_car_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "short_overview": shortOverview,
        "passengers": passengers,
        "mileage": mileage,
        "price_by_day": priceByDay,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "full_overview": fullOverview,
        "is_available": isAvailable,
        "id_car_model": idCarModel,
        "doors": doors,
        "type": type,
        "fuel_type": fuelType,
        "year": year,
        "id_car_type": idCarType,
      };
}
