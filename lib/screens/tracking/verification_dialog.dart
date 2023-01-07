import 'package:cargo/constants.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/screens/agent/dashboard/widgets/Db4Widget.dart';
import 'package:cargo/screens/tracking/shipment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class VerificationDialog extends StatefulWidget {
  const VerificationDialog({Key? key}) : super(key: key);

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
  String sms = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final cargo = Provider.of<CargoProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            SizedBox(
              height: 100,
              child: SvgPicture.asset(
                'assets/images/t10_ic_otp.svg',
                width: width * 0.25,
                height: width * 0.4,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            text('We are sending a verification code to ${cargo.phoneNumber!}',
                fontSize: 14, textColor: Colors.blueGrey, isCentered: true),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  sms = val;
                });

                if (cargo.sms == sms) {
                  Navigator.of(context).pop();
                  Get.off(() => ShipmentDetails(cargo: cargo.cargo));
                }
              },
              cursorColor: const Color(0xFF554BDF),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                hintText: 'RESEND OTP',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF554BDF),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AppButton(
              height: 45,
              color: kPrimaryColor,
              onTap: () {
                if (cargo.sms == sms) {
                  Navigator.of(context).pop();
                  Get.off(() => ShipmentDetails(cargo: cargo.cargo));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Wrong OTP'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              text: 'Submit',
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                text('Did not receive OTP? ',
                    textColor: Colors.grey, fontFamily: 'Medium', fontSize: 14),
                const SizedBox(width: 4),
                InkWell(
                    onTap: () async {
                      await cargo.twilioFlutter!.sendSMS(
                          toNumber: '+${cargo.phoneNumber!}',
                          messageBody:
                              'Dear customer, your verificication code for shipment ${cargo.cargo.docNo} is ${cargo.sms} . Fastgate cargo Services');
                    },
                    child: text('Enter OTP',
                        fontFamily: 'Medium',
                        fontSize: 14,
                        textColor: const Color(0xFF554BDF)))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            text(
                'Message sent to ${'${cargo.phoneNumber!.substring(0, 4)}* * * * * *${cargo.phoneNumber!.substring(10, cargo.phoneNumber!.length - 1)}'}',
                fontSize: 14),
          ],
        ),
      ),
    );
  }
}
