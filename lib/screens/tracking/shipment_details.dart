import 'package:cargo/constants.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:cargo/widgets/shipment_tracking_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        elevation: 0,
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
          Row(
            children: [
              FxText.titleMedium(
                'Tracking Info'.toUpperCase(),
                fontWeight: 700,
              ),
              const Spacer(),
              FxText.bodyMedium(
                cargo.deliveryDate == null
                    ? 'Not yet delivered'
                    : cargo.deliveryDate!
                                .toDate()
                                .difference(DateTime.now())
                                .inDays <
                            1
                        ? 'Delivered'
                        : '${cargo.deliveryDate!.toDate().difference(DateTime.now()).inDays} days left',
                color: Colors.green,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                trackingWidget(
                    cargo.origin!,
                    'Tracking No: '
                    '${cargo.docNo!}'),
                const SizedBox(height: 20),
                trackingWidget(cargo.destination!,
                    'Package: ${cargo.packageName!} - ${cargo.weight!.replaceAll('Kg', '')} Kg'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FxText.bodySmall(
                      'Shipping fee: ',
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    FxText.bodyMedium(
                      'KES ${cargo.shippingFee!}',
                      color: Colors.green,
                      fontWeight: 700,
                    ),
                  ],
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FxText.titleMedium(
            'Details'.toUpperCase(),
            fontWeight: 700,
          ),
          // detail(context, 'Tracking number', cargo.docNo!),
          // detail(
          //     context,
          //     'Booked At',
          //     DateFormat('dd MMM yyyy HH:mm')
          //         .format(DateTime.parse(cargo.createdAt.toString()))),
          // detail(context, 'Invoice No', cargo.invoiceNumber!),
          // detail(context, 'From', cargo.origin!),
          // detail(context, 'Destination', cargo.destination!),
          // detail(context, 'Cur.\nLocation', cargo.currentLocation!),
          // detail(
          //     context,
          //     'Cur.\nStatus',
          //     cargo.currentLocation == cargo.destination
          //         ? 'Received at Destination Depot'
          //         : 'On Transit'),
          // detail(context, 'Payment Mode', cargo.paymentMode!),
          const SizedBox(height: 20),
          detail2(
            isNull: cargo.received == null,
          ),
          detail2(
              icon: Icons.local_shipping_outlined,
              time: cargo.shipping != null
                  ? cargo.shipping!.date!.toDate()
                  : DateTime.now(),
              title: 'Shipment is on its way',
              value: cargo.shipping != null
                  ? cargo.shipping!.location!
                  : 'Location',
              isNull: cargo.shipping == null),
          detail2(
              icon: Icons.directions_boat_outlined,
              time: cargo.inShipment != null
                  ? cargo.inShipment!.date!.toDate()
                  : DateTime.now(),
              title: 'In Ship Transfer',
              value: cargo.inShipment != null
                  ? cargo.inShipment!.location!
                  : 'Location',
              isNull: cargo.inShipment == null),
          detail2(
              icon: Icons.local_shipping_outlined,
              time: cargo.inShipment != null
                  ? cargo.inShipment!.date!.toDate()
                  : DateTime.now(),
              title: 'Shipment is on its way',
              value: cargo.inShipment != null
                  ? cargo.inShipment!.location!
                  : 'Location',
              isNull: cargo.inShipment == null),
          detail2(
              icon: Icons.card_giftcard_rounded,
              time: cargo.readyForDelivery != null
                  ? cargo.readyForDelivery!.date!.toDate()
                  : DateTime.now(),
              title: 'Ready for delivery',
              value: cargo.readyForDelivery != null
                  ? cargo.readyForDelivery!.location!
                  : 'Location',
              isNull: cargo.readyForDelivery == null),
          detail2(
              icon: Icons.delivery_dining_outlined,
              time: cargo.onDelivery != null
                  ? cargo.onDelivery!.date!.toDate()
                  : DateTime.now(),
              title: 'On Delivery',
              value: cargo.onDelivery != null
                  ? cargo.onDelivery!.location!
                  : 'Location',
              isNull: cargo.onDelivery == null),
          detail2(
              icon: Icons.receipt_long_outlined,
              time: cargo.delivered != null
                  ? cargo.delivered!.date!.toDate()
                  : DateTime.now(),
              title: 'Delivered',
              value: cargo.onDelivery != null
                  ? cargo.onDelivery!.location!
                  : 'Location',
              isLast: true,
              isNull: cargo.delivered == null),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget trackingWidget(String title, String value,
      {bool hasIcon = true, bool isNull = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (hasIcon)
              Icon(Icons.circle,
                  color: isNull ? Colors.grey : kPrimaryColor, size: 10),
            if (hasIcon) const SizedBox(width: 10),
            FxText.bodyMedium(
              title,
              fontWeight: 700,
              color: isNull ? Colors.grey : null,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            if (hasIcon) const SizedBox(width: 20),
            FxText.bodySmall(
              value,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  Widget detail2({
    String? title,
    String? value,
    IconData? icon,
    DateTime? time,
    bool isLast = false,
    bool isNull = false,
  }) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isNull ? Colors.grey : kPrimaryColor,
              child:
                  Icon(icon ?? Icons.location_on_outlined, color: Colors.white),
            ),
            if (!isLast)
              Container(
                height: 30,
                width: 3,
                color: isNull ? Colors.grey : kPrimaryColor,
              )
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: trackingWidget(title ?? 'Shipping received', value ?? '',
                hasIcon: false, isNull: isNull)),
        if (!isNull)
          trackingWidget(
              DateFormat('dd MMM').format(time ?? cargo.createdAt!.toDate()),
              DateFormat('HH:mm').format(time ?? cargo.createdAt!.toDate()),
              hasIcon: false,
              isNull: isNull),
      ],
    );
  }
}
