import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {

  Future<void> initNotifications() async {
    FlutterLocalNotificationsPlugin localNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('images/launch_icon.png');
    var initializationSettings = InitializationSettings(android: android);
    localNotificationsPlugin.initialize(initializationSettings);

    var androidDetails = const AndroidNotificationDetails(
        'channel id', 'channel name',
        importance: Importance.max, priority: Priority.high);

    var details = NotificationDetails(android: androidDetails);
    localNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch >> 10,
        '訊息標題',
        '訊息內容',
        details  //剛才的訊息通知規格變數
    );
  }
}
