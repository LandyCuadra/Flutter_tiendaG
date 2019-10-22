import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

NotificationDetails get _ongoing{
  var androidChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High);
  var iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(
      androidChannelSpecifics, iOSChannelSpecifics);
}

Future showOngoingNotifications(
FlutterLocalNotificationsPlugin notification,{
  @required String title,
  @required String body,
  int id = 0,
  String payload = ""
}
) => _showNotification(notification, title: title, body: body, payload: payload);

Future _showNotification(

  FlutterLocalNotificationsPlugin notification,{
    @required String title,
    @required String body,
    String payload,
    int id = 0
}) => notification.show(id, title, body, _ongoing, payload: payload);