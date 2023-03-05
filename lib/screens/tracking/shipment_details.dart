import 'package:cargo/constants.dart';
import 'package:cargo/models/cargo_model.dart';
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
          fontWeight: 700,
        ),
        centerTitle: true,
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
          Row(
            children: [
              FxText.titleMedium(
                'Tracking Info'.toUpperCase(),
                fontWeight: 700,
              ),
              const Spacer(),
              FxText.bodySmall('Est. Delivery: '),
              FxText.bodySmall(
                cargo.deliveryDate == null
                    ? 'Not yet delivered'
                    : DateFormat('dd/MM/yyyy')
                        .format(cargo.deliveryDate!.toDate()),
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
                trackingWidget(
                    cargo.destination!, 'Description: ${cargo.packageName!}'),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FxText.titleMedium(
            'STATUS'.toUpperCase(),
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
              isNull: cargo.received == null, value: cargo.received!.location),
          detail2(
              icon: Icons.local_shipping_outlined,
              time: cargo.shipping != null
                  ? cargo.shipping!.date!.toDate()
                  : DateTime.now(),
              title: 'Shipment has been loaded',
              value: cargo.shipping != null ? cargo.shipping!.location! : '-',
              isNull: cargo.shipping == null),

          detail2(
              icon: Icons.local_shipping_outlined,
              time: cargo.inShipment != null
                  ? cargo.inShipment!.date!.toDate()
                  : DateTime.now(),
              title: 'Shipment is on its way',
              value:
                  cargo.inShipment != null ? cargo.inShipment!.location! : '-',
              isNull: cargo.inShipment == null),
          detail2(
              icon: Icons.card_giftcard_rounded,
              time: cargo.readyForDelivery != null
                  ? cargo.readyForDelivery!.date!.toDate()
                  : DateTime.now(),
              title: cargo.readyForDelivery != null
                  ? 'Arrived at ${cargo.readyForDelivery!.location}'
                  : 'Arrived at destination',
              value: cargo.readyForDelivery != null
                  ? cargo.readyForDelivery!.location!
                  : '-',
              isNull: cargo.readyForDelivery == null),

          detail2(
              icon: Icons.receipt_long_outlined,
              time: cargo.delivered != null
                  ? cargo.delivered!.date!.toDate()
                  : DateTime.now(),
              title: 'Delivered',
              value:
                  cargo.onDelivery != null ? cargo.onDelivery!.location! : '-',
              isLast: true,
              isNull: cargo.delivered == null),
          const SizedBox(height: 20),
          FxText.titleMedium(
            'CUSTOMER INFORMATION'.toUpperCase(),
            fontWeight: 700,
          ),
          const SizedBox(height: 20),

          customerDet('Receiver', cargo.customerName!),
          const SizedBox(
            height: 15,
          ),
          customerDet('Receiver\'s phone number', cargo.phoneNumber!),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              FxText(
                'Cost',
                color: Colors.grey,
                fontSize: 12,
              ),
              const Spacer(),
              FxText(
                cargo.delivered != null ? 'Paid' : 'Not paid',
                color: cargo.delivered != null ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              FxText(
                'Total',
                fontSize: 16,
              ),
              const Spacer(),
              FxText(
                'KES ${cargo.shippingFee}',
                fontSize: 16,
                fontWeight: 600,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Column customerDet(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText(
          title,
          color: Colors.grey,
          fontSize: 12,
        ),
        const SizedBox(
          height: 5,
        ),
        FxText(
          value,
          fontSize: 14,
        ),
        const Divider(),
      ],
    );
  }

  Widget trackingWidget(String title, String value,
      {bool hasIcon = true, bool isNull = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            if (hasIcon)
              Icon(Icons.circle,
                  color: isNull ? Colors.grey : kPrimaryColor, size: 10),
            if (hasIcon) const SizedBox(width: 10),
            FxText.bodyMedium(
              title,
              fontWeight: 600,
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
            child: trackingWidget(
                title ?? 'Shipping has been received', value ?? '',
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
