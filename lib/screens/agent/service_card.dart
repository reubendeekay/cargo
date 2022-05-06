import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {Key? key, this.description, this.image, this.onTap, this.title})
      : super(key: key);
  final String? title;
  final String? description;
  final String? image;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('assets/images/' + image!),
            ),
            const SizedBox(
              height: 18,
            ),
            FxText.titleMedium(
              title ?? 'Branches',
              fontWeight: 700,
            ),
            const SizedBox(
              height: 10,
            ),
            FxText.bodySmall(
              description ?? 'Talk to experts',
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
