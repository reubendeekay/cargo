import 'package:cargo/constants.dart';
import 'package:cargo/helpers/url_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchContactWidget extends StatelessWidget {
  const BranchContactWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mrreubenyt@gmail.com',
      query: encodeQueryParameters(
          <String, String>{'subject': 'Hello, I have this issue...'}),
    );
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: kPrimaryColor,
      ),
      title: const Text('Mombasa Depot'),
      trailing: GestureDetector(
          onTap: () async {
            await launch(emailLaunchUri.toString());
          },
          child: const Icon(Icons.email_outlined)),
    );
  }
}
