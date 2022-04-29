import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:cargo/widgets/shipment_tracking_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:intl/intl.dart';

class ShipmentDetails extends StatelessWidget {
  const ShipmentDetails({Key? key, required this.cargo}) : super(key: key);
  final CargoModel cargo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FxText.titleMedium(
          'Shipment Details',
        ),
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          detail(context, 'Tracking number', cargo.docNo!),
          detail(
              context,
              'Booked At',
              DateFormat('dd MMM yyyy HH:mm')
                  .format(DateTime.parse(cargo.createdAt.toString()))),
          detail(context, 'Invoice No', cargo.invoiceNumber!),
          detail(context, 'From', cargo.origin!),
          detail(context, 'Destination', cargo.destination!),
          detail(context, 'Cur.\nLocation', cargo.currentLocation!),
          detail(
              context,
              'Cur.\nStatus',
              cargo.currentLocation == cargo.destination
                  ? 'Received at Destination Depot'
                  : 'On Transit'),
          detail(context, 'Payment Mode', cargo.paymentMode!),
          const SizedBox(height: 20),
          ShipmentTrackingStepper(cargo: cargo),
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
