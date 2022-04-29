import 'package:flutter/material.dart';

class MyDateWidget extends StatelessWidget {
  const MyDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), border: Border.all()),
      height: 40,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '30/12/2021',
            style: TextStyle(fontSize: 13),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.grey[400],
            height: double.infinity,
            width: 30,
            child: const Center(
              child: Text(
                'to',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const Text(
            '30/12/2021',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
