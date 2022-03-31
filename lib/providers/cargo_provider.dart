import 'package:cargo/models/cargo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CargoProvider with ChangeNotifier {
  CargoModel? _cargo;
  CargoModel get cargo => _cargo!;

  Future<void> addCargo(CargoModel cargo) async {
    _cargo = cargo;

    await FirebaseFirestore.instance
        .collection('cargos')
        .doc(cargo.docNo)
        .set(cargo.toJson());
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

    return CargoModel.fromJson(results.data()!);
  }
}
