import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:cargo/widgets/shipment_tracking_stepper.dart';
import 'package:flutter/material.dart';

class ShipmentDetails extends StatelessWidget {
  const ShipmentDetails({Key? key, required this.cargo}) : super(key: key);
  final CargoModel cargo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.local_shipping),
            SizedBox(width: 10),
            Text('Shipment Details'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          const Center(
            child: Logo(),
          ),
          MyBorderWidget(
            child: Column(
              children: [
                detail(context, 'Doc No', cargo.docNo!),
                detail(context, 'Date', cargo.deliveryDate.toString()),
                detail(context, 'Invoice No', cargo.invoiceNumber!),
                detail(context, 'Origin', cargo.origin!),
                detail(context, 'Destination', cargo.destination!),
                detail(context, 'Cur.\nLocation', cargo.currentLocation!),
                detail(
                    context, 'Cur.\nStatus', 'Received at Destination Depot'),
                detail(context, 'POD', 'Download POD'),
                detail(context, 'Payment Mode', cargo.paymentMode!),
              ],
            ),
          ),
          const ShipmentTrackingStepper(),
        ],
      ),
    );
  }

  Widget detail(BuildContext context, String title, String value) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              SizedBox(width: size.width * .2, child: Text(title)),
              const SizedBox(width: 10),
              const Icon(
                Icons.more_vert,
                size: 14,
              ),
              const SizedBox(width: 10),
              Expanded(child: SizedBox(child: Text(value))),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.5,
          color: Colors.grey[400],
        )
      ],
    );
  }
}
