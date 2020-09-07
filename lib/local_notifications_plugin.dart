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

   Future<void> showSingleNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
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
      0,                      // Notification ID
      'Pressure Reminder',           // Notification Title
      'The device has quantified that 12 minutes has passed. Please adjust the sitting position of your child',            // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: 'New Payload', // Notification Payload
    );
  }
}

