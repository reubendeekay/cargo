import 'package:cargo/constants.dart';
import 'package:cargo/models/notification_model.dart';
import 'package:cargo/providers/notifications_provider.dart';
import 'package:cargo/screens/notifications/add_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Provider.of<NotificationsProvider>(context, listen: false)
            .getNotifications();
      },
      backgroundColor: kPrimaryColor,
      child: Scaffold(
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
        body: FutureBuilder<List<NotificationModel>>(
            future: Provider.of<NotificationsProvider>(context, listen: false)
                .getNotifications(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: FxText.titleMedium(
                    'Error: ${snapshot.error}',
                    color: Colors.red,
                  ),
                );
              }

              if (snapshot.data!.isEmpty) {
                return Center(
                  child: FxText.titleMedium(
                    'No Notifications yet',
                    color: Colors.grey,
                  ),
                );
              }

              return AdminNotifications(
                nots: snapshot.data!,
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddNotificationsScreen());
          },
          child: const Icon(Icons.add),
        ),
      ),
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
      controlsBuilder: widget.nots.isEmpty
          ? null
          : (BuildContext context, ControlsDetails details) {
              return _buildControlBuilder();
            },
      currentStep: _currentStep,
      onStepTapped: (pos) {
        setState(() {
          _currentStep = pos;
        });
      },
      steps: widget.nots.isEmpty
          ? [
              Step(
                  isActive: true,
                  title:
                      FxText.bodyLarge("No Notifications yet", fontWeight: 600),
                  content: const Text('Add New Notifications'))
            ]
          : widget.nots
              .map(
                (not) => Step(
                  isActive: _currentStep == widget.nots.indexOf(not),
                  title: FxText.bodyLarge(not.category!, fontWeight: 600),
                  subtitle:
                      FxText.bodySmall('By ${not.createdBy!}', fontWeight: 500),
                  state: StepState.indexed,
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FxText.bodySmall(" - ${not.message!}",
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
              Provider.of<NotificationsProvider>(context, listen: false)
                  .deleteNotification(widget.nots[_currentStep].id!);
              setState(() {
                widget.nots.removeAt(_currentStep);
              });
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
