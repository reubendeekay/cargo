import 'package:cargo/screens/agent/add_booking.dart';
import 'package:cargo/screens/agent/alerts.dart';
import 'package:cargo/screens/agent/rate_request.dart';
import 'package:cargo/screens/agent/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> exportTypes = [
  'Sea Export',
  'Sea Import',
  'Air Export',
  'Air Import',
  'Land Export',
  'Land Import',
];

List<String> dashboardTitles = [
  'My Booking',
  'My Alerts',
  'Tracking',
  'Rate Request',
  'Logistics Management',
];

List<IconData> dashboardIcons = [
  FontAwesomeIcons.laptop,
  FontAwesomeIcons.bell,
  FontAwesomeIcons.mapMarkedAlt,
  FontAwesomeIcons.file,
  FontAwesomeIcons.book
];

List<Widget> dashboardWidgets = const [
  AddBookingScreen(),
  AlertsScreen(),
  TrackingScreen(),
  RateRequest(),
  TrackingScreen(),
];

List<String> alertTypes = [
  'All',
  'Bookings',
  'Jobs',
];
List<String> alertVariables = [
  'Shipment Date',
  'Shipper Name',
  'Port of Loading',
  'POrt of Discharge',
  'Module',
  'Consignee Name',
  'Shipment Status',
];

List<String> tableColumns = [
  'Shipment No',
  'Origin',
  'Destination',
  'Pickup Date',
  'Delivery Date',
];

List<List> tableRows = [
  [
    'DEL/SE/J01941',
    'India',
    'Australia',
    '23/04/2021',
    '12/12/2021',
  ],
  [
    'DEL/AE/J01942',
    'Australia',
    'Kenya',
    '21/08/2021',
    '12/11/2021',
  ],
  [
    'DEL/SE/J01943',
    'China',
    'Uganda',
    '23/04/2021',
    '02/10/2021',
  ],
  [
    'DEL/SE/J01944',
    'Dubai',
    'Kenya',
    '01/04/2021',
    '12/12/2021',
  ],
  [
    'DEL/SE/J04941',
    'India',
    'Tanzania',
    '13/04/2021',
    '12/12/2021',
  ],
  [
    'DEL/SE/J03441',
    'USA',
    'Ethiopia',
    '27/04/2021',
    '12/12/2021',
  ],
  [
    'DEL/SE/J03442',
    'UK',
    'Kenya',
    '23/04/2021',
    '12/12/2022',
  ],
  [
    'DEL/SE/J03443',
    'Madagascar',
    'Tanzania',
    '23/04/2021',
    '12/12/2022',
  ],
];

List<String> typeOfCommodities = [
  'General',
  'Haz',
  'Perishable',
];

List<String> typeOfEquipments = [
  'General',
  'Special Equipment',
  'Break-bulk',
];
