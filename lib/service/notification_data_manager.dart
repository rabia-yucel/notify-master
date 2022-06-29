import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notify/service/session_data_manager.dart';

class NotificationDataManager {
  static final NotificationDataManager _singleton = NotificationDataManager._internal();

  static Future<void> saveNotification(RemoteMessage notificationMessageData, String eventName)  async {

    String avatarStr = '';

    await FirebaseFirestore.instance.collection('company_info')
    .where('company_name', isEqualTo: notificationMessageData.notification?.title)
    .get()
    .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        avatarStr = doc['avatar'];
      });
    });

    var currentTime = DateTime.now();

    CollectionReference userNotifications = FirebaseFirestore.instance.collection('user_notifications');

    return userNotifications
        .add({
      'avatar': avatarStr,
      'image_path': '',
      'event_name': eventName,
      'is_deleted': false,
      'is_read': true,
      'from' : notificationMessageData.from,
      'message_id' : notificationMessageData.messageId,
      'message_text': notificationMessageData.notification?.body,
      'notifier_name': notificationMessageData.notification?.title,
      'sent_time': notificationMessageData.sentTime,
      'sender_id': notificationMessageData.senderId,
      'instance_time': currentTime,
      'update_time': currentTime,
      'user_id': SessionDataManager.getUserId(),
    })
    .then((value) => print("Notification Added"))
    .catchError((error) => print("Failed to add notification: $error"));

  }

  static Future<void> subscribeToAllTopics() async {
    await FirebaseMessaging.instance.subscribeToTopic('bank');
    await FirebaseMessaging.instance.subscribeToTopic('merchant');
  }

  static Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  factory NotificationDataManager() {
    return _singleton;
  }

  NotificationDataManager._internal();
}