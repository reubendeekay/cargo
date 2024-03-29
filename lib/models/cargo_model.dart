import 'package:cargo/helpers/parse_phone.dart';
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
  String? shippingFee;
  String? weight;
  String? shippingType;
  String? carrierNo;
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
    this.weight,
    this.carrierNo,
    this.shippingType,
  });

  factory CargoModel.fromJson(DocumentSnapshot json) => CargoModel(
        docNo: json.id,
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
        // carrierNo: json["carrierNo"],
        // shippingType: json['shippingType'],
        packageName: json["packageName"],
        weight: (json["weight"] ?? '') + ' Kg',
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
        "id": docNo!.toUpperCase(),
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
        "weight": weight,
        'shippingType': shippingType,
        'carrierNo': carrierNo,
      };

  List<String> row() {
    return [
      docNo!.replaceAll('_', '/'),
      origin!,
      destination!,
      parsePhone(phoneNumber!),
      currentLocation!,
      DateFormat('dd/MMM/yyyy').format(createdAt!.toDate()),
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
