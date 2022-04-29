import 'package:cargo/helpers/send_sms.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CargoProvider with ChangeNotifier {
  CargoModel? _cargo;
  CargoModel get cargo => _cargo!;
  String? sms;
  String? phoneNumber;

  Future<void> addCargo(CargoModel cargo) async {
    _cargo = cargo;

    final doc = cargo.docNo!.split('/').join('_');

    await FirebaseFirestore.instance
        .collection('cargos')
        .doc(doc)
        .set(cargo.toJson());

    await twilioFlutter.sendSMS(
        toNumber: '+' + cargo.phoneNumber!,
        messageBody:
            'Dear customer, your shipment has been added. Monitor and track it using the tracking number ${cargo.docNo!}.');

    notifyListeners();
  }

  Future<CargoModel> fetchUserCargo(String docNo) async {
    final cargoSnapshot = await FirebaseFirestore.instance
        .collection('cargos')
        .doc(docNo.replaceAll('/', '_'))
        .get();
    notifyListeners();
    return _cargo = CargoModel.fromJson(cargoSnapshot);
  }

  Future<void> getShipment(String trackingNo) async {
    sms == '';
    final results = await FirebaseFirestore.instance
        .collection('cargos')
        .doc(trackingNo.replaceAll('/', '_'))
        .get();
    final key = UniqueKey();
    sms = key.toString();
    final cargo = CargoModel.fromJson(results.data()!);
    await twilioFlutter.sendSMS(
        toNumber: '+' + cargo.phoneNumber!,
        messageBody:
            'Dear customer, your verificication code for shipment ${cargo.docNo} is $key . Fastgate cargo Services');
    _cargo = cargo;
    phoneNumber = cargo.phoneNumber!;
  }

  Future<List<CargoModel>> fetchAllCargo() async {
    final results = await FirebaseFirestore.instance.collection('cargos').get();

    final List<CargoModel> cargos = [];
    for (var cargo in results.docs) {
      cargos.add(CargoModel.fromJson(cargo));
    }
    return cargos;
  }
}
