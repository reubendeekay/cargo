import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CargoModel {
  final String? docNo;
  final String? customerName;
  final Timestamp? createdAt;
  final String? origin;
  final String? destination;
  final String? paymentMode;
  final String? invoiceNumber;
  final String? currentLocation;
  final Timestamp? deliveryDate;
  final String? userId;
  final String? shippingFee;
  final String? packageName;
  final String? phoneNumber;
  CargoStatus? received;
  CargoStatus? delivered;
  CargoStatus? shipping;
  CargoStatus? onDelivery;
  CargoStatus? inShipment;
  CargoStatus? readyForDelivery;

  CargoModel({
    this.docNo,
    this.packageName,
    this.customerName,
    this.phoneNumber,
    this.createdAt,
    this.origin,
    this.destination,
    this.paymentMode,
    this.invoiceNumber,
    this.currentLocation,
    this.deliveryDate,
    this.userId,
    this.received,
    this.delivered,
    this.shipping,
    this.onDelivery,
    this.inShipment,
    this.readyForDelivery,
    this.shippingFee,
  });

  factory CargoModel.fromJson(dynamic json) => CargoModel(
        docNo: json["id"],
        createdAt: json["createdAt"],
        origin: json["origin"],
        destination: json["destination"],
        paymentMode: json["paymentMode"],
        invoiceNumber: json["invoiceNumber"],
        currentLocation: json["currentLocation"],
        userId: json["userId"],
        shippingFee: json["shippingFee"],
        phoneNumber: json["phoneNumber"],
        customerName: json["customerName"],
        deliveryDate: json["deliveryDate"],
        packageName: json["packageName"],
        delivered: json["delivered"] == null
            ? null
            : CargoStatus.fromJson(json["delivered"]),
        inShipment: json["inShipment"] == null
            ? null
            : CargoStatus.fromJson(json["inShipment"]),
        onDelivery: json["onDelivery"] == null
            ? null
            : CargoStatus.fromJson(json["onDelivery"]),
        received: json["received"] == null
            ? null
            : CargoStatus.fromJson(json["received"]),
        shipping: json["shipping"] == null
            ? null
            : CargoStatus.fromJson(json["shipping"]),
        readyForDelivery: json["readyForDelivery"] == null
            ? null
            : CargoStatus.fromJson(json["readyForDelivery"]),
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
        "phoneNumber": phoneNumber,
        "customerName": customerName,
        "deliveryDate": deliveryDate,
        "packageName": packageName,
        "delivered": delivered?.toJson(),
        "inShipment": inShipment?.toJson(),
        "onDelivery": onDelivery?.toJson(),
        "received": received?.toJson(),
        "shipping": shipping?.toJson(),
        "readyForDelivery": readyForDelivery?.toJson(),
        "shippingFee": shippingFee,
      };

  List<String> row() {
    return [
      docNo!,
      origin!,
      destination!,
      phoneNumber!,
      currentLocation!,
      DateFormat('dd/MMM/yyyy').format(createdAt!.toDate()),
      paymentMode!,
    ];
  }
}

class CargoStatus {
  Timestamp? date;
  String? location;

  CargoStatus(this.date, this.location);

  factory CargoStatus.fromJson(dynamic json) => CargoStatus(
        json["date"],
        json["location"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "location": location,
      };
}
