import 'package:cargo/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShipmentTrackingStepper extends StatelessWidget {
  const ShipmentTrackingStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          icon(),
          icon(
              title: 'Transit Depot\nWAGHOLI',
              icon: FontAwesomeIcons.planeDeparture),
          icon(
            title: 'Destination Depot\nMOMBASA',
            icon: FontAwesomeIcons.planeArrival,
          ),
          icon(
              title: 'Dispatched Item',
              color: Colors.red,
              icon: FontAwesomeIcons.truckMoving),
          icon(
              title: 'Product Delivered',
              isLast: true,
              color: Colors.red,
              icon: FontAwesomeIcons.peopleCarry),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget icon(
      {String? title, Color? color, bool isLast = false, IconData? icon}) {
    return Row(
      children: [
        const SizedBox(
          width: 50,
        ),
        SizedBox(
          width: 120,
          child: Text(
            title ?? 'Consignment Booked\nCHINA',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: color ?? kPrimaryColor, shape: BoxShape.circle),
                child: Icon(
                  icon ?? FontAwesomeIcons.dropbox,
                  color: Colors.white,
                )),
            if (!isLast)
              Container(
                height: 50,
                width: 8,
                color: color ?? kPrimaryColor,
              ),
          ],
        ),
      ],
    );
  }
}
