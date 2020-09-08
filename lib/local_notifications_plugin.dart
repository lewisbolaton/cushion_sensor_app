import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsPlugin {
  FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  LocalNotificationsPlugin() {
    this._localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS
    );
    await this._localNotificationsPlugin.initialize(
        initializationSettings, onSelectNotification: selectNotification
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
  }

   Future<void> showSingleReminder() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'single_reminder',
      'Single reminder',
      'Notification channel for non-periodic reminders only shown once',
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidChannelSpecifics, iosChannelSpecifics
    );
    await this._localNotificationsPlugin.show(
      0,
      'Pressure warning',
      'Please adjust the sitting position of your child',
      platformChannelSpecifics,
    );
  }

  Future<void> startShowingPeriodicReminder() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'periodic_reminder',
      'Periodic reminder',
      'Notification channel for reminder shown every 10 minutes',
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidChannelSpecifics, iosChannelSpecifics
    );
    for (int i = 50; i >= 0; i -= 10) {
      await this._localNotificationsPlugin.periodicallyShow(
        60 - i,
        'Pressure reminder',
        'Please adjust the sitting position of your child',
        RepeatInterval.Hourly,
        platformChannelSpecifics,
        advance: Duration(minutes: i),
      );
    }
  }
}

