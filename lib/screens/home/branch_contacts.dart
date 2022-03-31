import 'package:cargo/widgets/branch_contact_widget.dart';
import 'package:flutter/material.dart';

class BranchContactsScreen extends StatelessWidget {
  const BranchContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Branch Contacts'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: List.generate(15, (index) => const BranchContactWidget()),
      ),
    );
  }
}
