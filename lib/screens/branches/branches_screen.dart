import 'package:cargo/providers/branch_provider.dart';
import 'package:cargo/screens/branches/branch_contacts.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<BranchProvider>(context, listen: false).getBranches();
    });
  }

  String? country;
  String? region;
  @override
  Widget build(BuildContext context) {
    final branches =
        Provider.of<BranchProvider>(context, listen: false).branches;
    return Scaffold(
      appBar: AppBar(
          elevation: 0.5,
          title: FxText.bodyLarge("Branch Search",
              fontWeight: 600, letterSpacing: 0)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            MyDropDown(
              selectedOption: (val) {
                setState(() {
                  country = val;
                });
              },
              options: branches.map((e) => e.country.toString()).toList(),
              hintText: 'Select Country',
            ),
            if (country != null)
              MyDropDown(
                selectedOption: (val) {
                  setState(() {
                    region = val;
                  });
                },
                options: branches
                    .where((e) =>
                        e.country!.toLowerCase() == country!.toLowerCase())
                    .map((e) => e.region!.toString())
                    .toList(),
                hintText: 'Select Region',
              ),
            if (region != null && country != null)
              Row(
                children: [
                  FxText.bodyLarge(
                      branches
                              .where((element) =>
                                  element.region == region &&
                                  element.country == country)
                              .length
                              .toString() +
                          " results",
                      fontWeight: 600,
                      letterSpacing: 0),
                ],
              ),
            FxSpacing.height(20),
            if (region != null && country != null)
              Expanded(
                  child: BranchContactsScreen(
                branches: branches
                    .where((element) =>
                        element.region == region && element.country == country)
                    .toList(),
              ))
          ]),
        ),
      ),
    );
  }
}
