import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //Singleton en Dart? <3
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
