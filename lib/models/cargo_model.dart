class CargoModel {
  final String? docNo;
  final String? customerName;
  final String? createdAt;
  final String? origin;
  final String? destination;
  final String? paymentMode;
  final String? invoiceNumber;
  final String? currentLocation;
  final String? deliveryDate;
  final String? userId;

  CargoModel({
    this.docNo,
    this.customerName,
    this.createdAt,
    this.origin,
    this.destination,
    this.paymentMode,
    this.invoiceNumber,
    this.currentLocation,
    this.deliveryDate,
    this.userId,
  });

  factory CargoModel.fromJson(Map<String, dynamic> json) => CargoModel(
        docNo: json["id"],
        createdAt: json["createdAt"],
        origin: json["origin"],
        destination: json["destination"],
        paymentMode: json["paymentMode"],
        invoiceNumber: json["invoiceNumber"],
        currentLocation: json["currentLocation"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": docNo,
        "createdAt": createdAt,
        "origin": origin,
        "destination": destination,
        "paymentMode": paymentMode,
        "invoiceNumber": invoiceNumber,
        "currentLocation": currentLocation,
        "userId": userId,
      };
}
