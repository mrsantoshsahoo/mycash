// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationApi {
//   static final _notification = FlutterLocalNotificationsPlugin();
//   static String groupKey = 'com.exapmle.mycash';
//   static String groupChannelId = 'my cash';
//   static String groupChannelName = 'my cash';
//   static String groupChannelDescription = 'mycash notifications';
//   // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//   //   groupChannelId, groupChannelName, groupChannelDescription,
//   //   //   styleInformation: inboxStyleInformation,enableLights: true,
//   //   //   sound: RawResourceAndroidNotificationSound(sound.split(".").first),
//   //   importance: Importance.max,
//   //   priority: Priority.high,
//   //   groupKey: groupKey,
//   //   setAsGroupSummary: true,
//   //   largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
//   //   playSound: true,
//   // );
//
//   static Future _notificationDetails() async {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         groupChannelId,
//         groupChannelName,
//         groupChannelDescription,
//         importance: Importance.max,
//         priority: Priority.high,
//         groupKey: groupKey,
//         setAsGroupSummary: true,
//        largeIcon: const DrawableResourceAndroidBitmap("ic_launcher"),
//         playSound: true,
//       ),
//       iOS: IOSNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       ),
//     );
//   }
//
//   static Future showNotification({
//     int id = 1,
//     String? title,
//     String? body,
//     String? payload,
//   }) async =>
//     await  _notification.show(id, title, body, await _notificationDetails());
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("ic_launcher");
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)
        ),
        const NotificationDetails(
            android: AndroidNotificationDetails('main_channel', "Main_channel",
                importance: Importance.max, priority: Priority.max),
            iOS: IOSNotificationDetails(
              sound: 'default.wav',
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            )),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true
    );
  }
  Future<void> showNotification1({
    required int id,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        const NotificationDetails(

            android: AndroidNotificationDetails('main_channel', "Main_channel",
                importance: Importance.max, priority: Priority.max),
            iOS: IOSNotificationDetails(
              sound: 'default.wav',
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            )),
        // uiLocalNotificationDateInterpretation:
        // UILocalNotificationDateInterpretation.absoluteTime,
     //   androidAllowWhileIdle: true
    );
  }
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
// FlatButton(
//   onPressed: () async{
//      NotificationService().showNotification1(
//       id: 0,
//       title: "Mr vijay",
//       body: "Multi Stack Developer",
//     );
//   },
//   child: const Text("GetDAta"),
//   color: Colors.teal,
// )
}
