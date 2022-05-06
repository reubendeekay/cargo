import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class SmsProvider with ChangeNotifier {
  TwilioFlutter? twilioFlutter;

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
}
