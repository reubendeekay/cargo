import 'package:cargo/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NotificationsProvider with ChangeNotifier {
  Future<void> addNotification(NotificationModel notification) async {
    final ref = FirebaseFirestore.instance.collection('notifications').doc();
    await ref.set({'createdAt': Timestamp.now(), ...notification.toJson()});
    notifyListeners();
  }

  Future<void> deleteNotification(String id) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(id)
        .delete();
    notifyListeners();
  }

  Future<List<NotificationModel>> getNotifications() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .get()
        .then((value) {
      List<NotificationModel> notifications = [];
      for (var doc in value.docs) {
        notifications.add(NotificationModel.fromJson(doc));
      }
      return notifications;
    });
  }
}
