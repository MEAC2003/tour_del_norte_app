// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

List<Booking> bookingFromJson(String str) =>
    List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

String bookingToJson(List<Booking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booking {
  final int id;
  final String createdAt;
  final String fullName;
  final String email;
  final int phone;
  final int dni;
  final String license;
  final int idVehicle;
  final int qtyDays;
  final int total;
  final String idUser;

  Booking({
    required this.id,
    required this.createdAt,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.dni,
    required this.license,
    required this.idVehicle,
    required this.qtyDays,
    required this.total,
    required this.idUser,
  });

  Booking copyWith({
    int? id,
    String? createdAt,
    String? fullName,
    String? email,
    int? phone,
    int? dni,
    String? license,
    int? idVehicle,
    int? qtyDays,
    int? total,
    String? idUser,
  }) =>
      Booking(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        dni: dni ?? this.dni,
        license: license ?? this.license,
        idVehicle: idVehicle ?? this.idVehicle,
        qtyDays: qtyDays ?? this.qtyDays,
        total: total ?? this.total,
        idUser: idUser ?? this.idUser,
      );

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        createdAt: json["created_at"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
        dni: json["dni"],
        license: json["license"],
        idVehicle: json["id_vehicle"],
        qtyDays: json["qty_days"],
        total: json["total"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "dni": dni,
        "license": license,
        "id_vehicle": idVehicle,
        "qty_days": qtyDays,
        "total": total,
        "id_user": idUser,
      };
}
