import 'dart:math' as math;

import 'package:cargo/helpers/database.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class CargoProvider with ChangeNotifier {
  CargoModel? _cargo;
  CargoModel get cargo => _cargo!;
  String? sms;
  String? phoneNumber;
  TwilioFlutter? twilioFlutter;

  Future<void> addCargo(CargoModel cargo) async {
    _cargo = cargo;

    final doc = cargo.docNo!.split('/').join('_');

    await FirebaseFirestore.instance
        .collection('cargos')
        .doc(doc)
        .set(cargo.toJson());

    await twilioFlutter!.sendSMS(
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
    sms = getOtp().toString();
    final cargo = CargoModel.fromJson(results.data()!);

    if(twilioFlutter == null) {
      await initialiseTwillio();
    }
    await twilioFlutter!.sendSMS(
        toNumber: '+' + cargo.phoneNumber!,
        messageBody:
            'Dear customer, your verificication code for shipment ${cargo.docNo} is $sms . iCargo');

//SAVING SEARCHED CARGO TO LOCAL STORAGE
    Word word = Word();
    word.word = trackingNo;
    word.frequency = 1;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(word);
    print('inserted row: $id');

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

  Future<void> initialiseTwillio() async {
    final result =
        await FirebaseFirestore.instance.collection('sms').doc('config').get();

    twilioFlutter = TwilioFlutter(
      accountSid: result['accountSid'],
      authToken: result['authToken'],
      twilioNumber: result['twilioNumber'],
    );
    notifyListeners();
  }

  Future<void> updateTransit(
      CargoModel cargo, String status, String location) async {
    final doc = cargo.docNo!.split('/').join('_');
    await FirebaseFirestore.instance
        .collection('cargos')
        .doc(doc)
        .update(cargo.toJson());
         if(twilioFlutter == null) {
      await initialiseTwillio();
    }
    await twilioFlutter!.sendSMS(
        toNumber: '+' + cargo.phoneNumber!,
        messageBody:
            'Dear customer, your package with tracking ${cargo.docNo!.split('_').join('/')} is $status at $location. Thank you for choosing us. iCargo');

    notifyListeners();
  }
}

int getOtp() {
  var rnd = new math.Random();
  var next = rnd.nextDouble() * 1000000;
  while (next < 100000) {
    next *= 10;
  }
  return next.toInt();
}
