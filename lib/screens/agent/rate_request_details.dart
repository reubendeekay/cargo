import 'package:cargo/constants.dart';
import 'package:cargo/helpers/lists.dart';
import 'package:cargo/widgets/done_icon.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:cargo/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RateRequestDetails extends StatefulWidget {
  const RateRequestDetails({Key? key, required this.appBarTitle})
      : super(key: key);
  final String appBarTitle;

  @override
  State<RateRequestDetails> createState() => _RateRequestDetailsState();
}

class _RateRequestDetailsState extends State<RateRequestDetails> {
  IconData icons() {
    if (widget.appBarTitle == 'Sea Rate Request') {
      return FontAwesomeIcons.ship;
    } else if (widget.appBarTitle == 'Air Rate Request') {
      return FontAwesomeIcons.plane;
    } else {
      return FontAwesomeIcons.truck;
    }
  }

  String typeOfCommodity = 'Haz';
  String typeOfEquipment = 'Special Equipment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(icons()),
            const SizedBox(
              width: 10,
            ),
            Text(widget.appBarTitle)
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('INCOTERMS')),
                SizedBox(
                  height: 40,
                  child: myTextField(hint: 'EXW'),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Commodity')),
                MyDropDown(
                  selectedOption: (val) {},
                  hintText: typeOfCommodity,
                  options: typeOfCommodities,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Description of the Commodity')),
                SizedBox(
                  height: 40,
                  child: myTextField(hint: 'Electronic goods'),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Place of pick up')),
                SizedBox(
                  height: 40,
                  child: myTextField(hint: 'Mombasa,Kenya'),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Place of Loading')),
                SizedBox(
                  height: 40,
                  child: myTextField(hint: 'Chenai,India'),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Place of Discharge')),
                SizedBox(
                  height: 40,
                  child: myTextField(hint: 'EXW'),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Final Destination')),
                SizedBox(
                  height: 40,
                  child: myTextField(hint: 'Bangkok, Thailand'),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Type of Equipment')),
                MyDropDown(
                  selectedOption: (val) {},
                  options: typeOfEquipments,
                  hintText: typeOfEquipment,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Additional Information')),
                SizedBox(
                  height: 40,
                  child: myTextField(hint: 'Highly important'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: RaisedButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                content: const DoneIcon(),
                              ));

                      await Future.delayed(const Duration(milliseconds: 1500))
                          .then((_) => Navigator.pop(context));
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: kPrimaryColor,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
