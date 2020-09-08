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

  Future<void> showMultiplePeriodicNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 3',
      'CHANNEL_NAME 3',
      "CHANNEL_DESCRIPTION 3",
      importance: Importance.Max,
      priority: Priority.High,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);

    await this._localNotificationsPlugin.periodicallyShow(
      3,
      'Advanced hourly by 58 minutes',
      'This notification starts 58 minutes before first trigger',
      RepeatInterval.Hourly,
      platformChannelSpecifics,
      payload: 'Test Payload',
      advance: Duration(minutes: 58),
    );
    await this._localNotificationsPlugin.periodicallyShow(
      4,
      'Advanced hourly by 56 minutes',
      'This notification starts 56 minutes before first trigger',
      RepeatInterval.Hourly,
      platformChannelSpecifics,
      payload: 'Test Payload',
      advance: Duration(minutes: 56),
    );
    await this._localNotificationsPlugin.periodicallyShow(
      5,
      'Advanced hourly by 54 minutes',
      'This notification starts 54 minutes before first trigger',
      RepeatInterval.Hourly,
      platformChannelSpecifics,
      payload: 'Test Payload',
      advance: Duration(minutes: 54),
    );
  }
}

