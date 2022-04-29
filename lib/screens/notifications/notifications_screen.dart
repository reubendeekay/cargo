import 'package:cargo/models/notification_model.dart';
import 'package:cargo/providers/notifications_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

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

            return AdminNotifications(
              nots: docs.map((e) => NotificationModel.fromJson(e)).toList(),
            );
          }),
    );
  }
}

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({Key? key, required this.nots}) : super(key: key);
  final List<NotificationModel> nots;

  @override
  _AdminNotificationsState createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  int _currentStep = 0;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Stepper(
      physics: const ClampingScrollPhysics(),
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return _buildControlBuilder();
      },
      currentStep: _currentStep,
      onStepTapped: (pos) {
        setState(() {
          _currentStep = pos;
        });
      },
      steps: widget.nots
          .map(
            (not) => Step(
              isActive: true,
              title: FxText.bodyLarge(not.category!, fontWeight: 600),
              subtitle:
                  FxText.bodySmall('By ' + not.createdBy!, fontWeight: 500),
              state: StepState.indexed,
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FxText.bodySmall(" - " + not.message!,
                    color: theme.colorScheme.onBackground),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildControlBuilder() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.center,
        child: FxButton(
            onPressed: () async {
              await Provider.of<NotificationsProvider>(context, listen: false)
                  .deleteNotification(widget.nots[_currentStep].id!);
            },
            elevation: 0,
            borderRadiusAll: 4,
            child: FxText.bodySmall("Delete".toUpperCase(),
                color: theme.colorScheme.onSecondary,
                letterSpacing: 0.3,
                fontWeight: 600)),
      ),
    );
  }
}
