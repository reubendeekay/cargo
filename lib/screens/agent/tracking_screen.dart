import 'package:cargo/constants.dart';
import 'package:cargo/helpers/lists.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:cargo/widgets/my_search_button.dart';
import 'package:cargo/widgets/my_table.dart';
import 'package:cargo/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  String? exportType;
  String? trackingNumber;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.local_shipping),
            SizedBox(width: 10),
            Text('Tracking'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Logo(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: kSecondaryColor, width: 2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: MyDropDown(
                              selectedOption: (value) {
                                setState(() {
                                  exportType = value;
                                });
                              },
                              hintText: 'Select',
                              options: exportTypes,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 40,
                            child: myTextField(
                                hint: 'Tracking No',
                                onChanged: (val) {
                                  setState(() {
                                    trackingNumber = val;
                                  });
                                }),
                          )),
                          const SizedBox(width: 10),
                          const MySearchButton()
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                        // margin: const EdgeInsets.only(top: 15),
                        width: size.width - 30,
                        child: MyTable(
                          columnNumber: tableColumns.length,
                          rowNumber: tableRows.length,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
