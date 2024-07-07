class Booking {
  final int? id;
  final String fullName;
  final String email;
  final String phone;
  final String dni;
  final String license;
  final int idCar;
  final DateTime startDate;
  final DateTime endDate;
  final int qtyDays;
  final int total;
  final String idUser;

  Booking({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.dni,
    required this.license,
    required this.idCar,
    required this.startDate,
    required this.endDate,
    required this.qtyDays,
    required this.total,
    required this.idUser,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      dni: json['dni'],
      license: json['license'],
      idCar: json['id_car'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      qtyDays: json['qty_days'],
      total: json['total'],
      idUser: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'dni': dni,
      'license': license,
      'id_car': idCar,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'qty_days': qtyDays,
      'total': total,
      'id_user': idUser,
    };
  }
}
