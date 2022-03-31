import 'package:cargo/helpers/send_sms.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CargoProvider with ChangeNotifier {
  CargoModel? _cargo;
  CargoModel get cargo => _cargo!;

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

  Future<void> fetchUserCargo(String docNo) async {
    final cargoSnapshot = await FirebaseFirestore.instance
        .collection('cargos')
        .doc(docNo.replaceAll('/', '_'))
        .get();
    _cargo = CargoModel.fromJson(cargoSnapshot.data()!);
    notifyListeners();
  }

  Future<CargoModel> getShipment(String trackingNo) async {
    final results = await FirebaseFirestore.instance
        .collection('cargos')
        .doc(trackingNo.replaceAll('/', '_'))
        .get();
    final key = UniqueKey();
    final cargo = CargoModel.fromJson(results.data()!);
    await twilioFlutter.sendSMS(
        toNumber: '+' + cargo.phoneNumber!,
        messageBody:
            'Dear customer, your verificication code for shipment ${cargo.docNo} is $key . Fastgate cargo Services');
    return cargo;
  }

  Future<List<CargoModel>> fetchAllCargo() async {
    final results = await FirebaseFirestore.instance.collection('cargos').get();

    final List<CargoModel> cargos = [];
    for (var cargo in results.docs) {
      cargos.add(CargoModel.fromJson(cargo.data()));
    }
    return cargos;
  }
}
