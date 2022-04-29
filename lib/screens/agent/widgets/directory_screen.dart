import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/screens/agent/widgets/my_date_widget.dart';
import 'package:cargo/widgets/my_search_button.dart';
import 'package:cargo/widgets/my_table.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';

class CargoDirectory extends StatefulWidget {
  const CargoDirectory({Key? key}) : super(key: key);

  @override
  State<CargoDirectory> createState() => _CargoDirectoryState();
}

class _CargoDirectoryState extends State<CargoDirectory> {
  String? alertType;

  String? alertVariable;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: FxText.titleMedium("Directory", fontWeight: 600),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
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
          FutureBuilder<List<CargoModel>>(
              future: Provider.of<CargoProvider>(context).fetchAllCargo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: size.width - 30,
                      child: MyTable(
                        cargos: snapshot.data!,
                      )),
                );
              }),
        ],
      ),
    );
  }
}
