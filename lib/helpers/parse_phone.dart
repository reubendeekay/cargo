import 'package:intl/intl.dart';

String parsePhone(String phone) {
  //Parse phone to 254xxxxxxxxx
  if (phone.startsWith('07')) {
    return phone.replaceFirst('07', '2547');
  }
  if (phone.startsWith('7')) {
    return phone.replaceFirst('7', '2547');
  }
  if (phone.startsWith('+2547')) {
    return phone.replaceFirst('+2547', '2547');
  }
  if (phone.startsWith('01')) {
    return phone.replaceFirst('01', '2541');
  }
  if (phone.startsWith('+2541')) {
    return phone.replaceFirst('+2541', '2541');
  }
  if (phone.startsWith('1')) {
    return phone.replaceFirst('1', '2541');
  }

  return phone;
}

String parseCurrency(String amount) {
  //Parse currency to 1,000.00
  final cash =
      NumberFormat.currency(locale: "en_US", symbol: "", decimalDigits: 1);
  return cash.format(double.parse(amount));
}
