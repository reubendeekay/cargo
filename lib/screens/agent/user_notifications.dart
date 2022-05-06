import 'package:cargo/models/notification_model.dart';
import 'package:cargo/screens/agent/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class UserNotifications extends StatelessWidget {
  const UserNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: FxText.titleMedium("Notifications", fontWeight: 600),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notifications')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: FxText.titleMedium(
                  'Error: ${snapshot.error}',
                  color: Colors.red,
                ),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: FxText.titleMedium(
                  'No Notifications yet',
                  color: Colors.grey,
                ),
              );
            }
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return Center(
                child: FxText.titleMedium(
                  'No Notifications yet',
                  color: Colors.grey,
                ),
              );
            }

            return NewsWidget(
              nots: docs.map((e) => NotificationModel.fromJson(e)).toList(),
            );
          }),
    );
  }
}
