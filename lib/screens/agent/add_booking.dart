import 'package:cargo/constants.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/widgets/my_text_field.dart';
import 'package:cargo/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({Key? key}) : super(key: key);

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  String? invoiceNumber;

  String? origin;

  String? destinaton;
  String? phoneNumber;

  String? paymentMode;

  String? customerName;
  String? deliveryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shipment'),
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [
          myTextField(
              hint: 'Invoice Number',
              onChanged: (val) {
                setState(() {
                  invoiceNumber = val;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          myTextField(
              hint: 'Customer Name',
              onChanged: (val) {
                setState(() {
                  customerName = val;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          myTextField(
              hint: 'Customer Phone(eg 2547123456678)',
              onChanged: (val) {
                setState(() {
                  phoneNumber = val;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          myTextField(
              hint: 'Cargo Origin',
              onChanged: (val) {
                setState(() {
                  origin = val;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          myTextField(
              hint: 'Cargo Destination',
              onChanged: (val) {
                setState(() {
                  destinaton = val;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          myTextField(
              hint: 'Payment Mode',
              onChanged: (val) {
                setState(() {
                  paymentMode = val;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          myTextField(
              hint: 'Delivery Date',
              onChanged: (val) {
                setState(() {
                  deliveryDate = val;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 50,
          ),
          PrimaryButton(
            buttonText: 'Add Shipment Details',
            color: kPrimaryColor,
            onPressed: () async {
              final cargo = CargoModel(
                createdAt: DateTime.now().toString(),
                customerName: customerName,
                currentLocation: origin,
                docNo: origin![0] +
                    origin![1] +
                    origin![2] +
                    '/' +
                    destinaton![0] +
                    destinaton![1] +
                    destinaton![2] +
                    '/' +
                    invoiceNumber!,
                destination: destinaton,
                phoneNumber: phoneNumber,
                invoiceNumber: invoiceNumber,
                origin: origin,
                paymentMode: paymentMode,
                deliveryDate: deliveryDate,
              );

              await Provider.of<CargoProvider>(context, listen: false)
                  .addCargo(cargo);
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Shipping details added to database'),
              ));
            },
            icon: Icons.add,
          )
        ]),
      ),
    );
  }
}
