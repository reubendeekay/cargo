import 'package:cargo/constants.dart';
import 'package:cargo/helpers/lists.dart';
import 'package:cargo/screens/agent/widgets/date_widget.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:cargo/widgets/my_search_button.dart';
import 'package:cargo/widgets/my_table.dart';
import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String? alertType;

  String? alertVariable;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.notifications),
            SizedBox(width: 10),
            Text('Alerts'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Center(
            child: Logo(),
          ),
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
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyDropDown(
                                  selectedOption: (value) {
                                    setState(() {
                                      alertVariable = value;
                                    });
                                  },
                                  hintText: 'Select',
                                  options: alertVariables,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: MyDropDown(
                                  selectedOption: (value) {
                                    setState(() {
                                      alertType = value;
                                    });
                                  },
                                  hintText: 'Select',
                                  options: alertTypes,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const MyDateWidget(),
                            const Spacer(),
                            MySearchButton(
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: size.width - 30,
                        child: MyTable(
                          columnNumber: tableColumns.length,
                          rowNumber: tableRows.length,
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
