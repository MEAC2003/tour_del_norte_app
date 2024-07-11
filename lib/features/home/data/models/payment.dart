class Payment {
  int? id;
  String? createdAt;
  int bookingId;
  String status;
  double amount;
  DateTime? cancelledAt;
  DateTime paymentDeadline;
  DateTime? paidAt;

  Payment({
    this.id,
    this.createdAt,
    required this.bookingId,
    required this.status,
    required this.amount,
    this.cancelledAt,
    required this.paymentDeadline,
    this.paidAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        createdAt: json["created_at"],
        bookingId: json["booking_id"],
        status: json["status"],
        amount: json["amount"]?.toDouble(),
        cancelledAt: json["cancelled_at"] != null
            ? DateTime.parse(json["cancelled_at"])
            : null,
        paymentDeadline: DateTime.parse(json["payment_deadline"]),
        paidAt:
            json["paid_at"] != null ? DateTime.parse(json["paid_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "booking_id": bookingId,
        "status": status,
        "amount": amount,
        "cancelled_at": cancelledAt?.toIso8601String(),
        "payment_deadline": paymentDeadline.toIso8601String(),
        "paid_at": paidAt?.toIso8601String(),
      };
}
