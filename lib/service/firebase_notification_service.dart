import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class FirebaseNotificationService{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseNotificationService._();
  static final FirebaseNotificationService instance = FirebaseNotificationService._();

  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      announcement: false,
      carPlay: false,
      provisional: false,
    );

    // Foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          print(message.notification?.title);
          print(message.notification?.body);
          print(message.data);

          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;

          const AndroidNotificationChannel channel = AndroidNotificationChannel(
            'high_importance_channel', // id
            'High Importance Notifications', // name
            description: 'This channel is used for important notifications.', // description
            importance: Importance.high,
          );

          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: android.smallIcon,
                ),
              ),
            );
          }

          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(channel);
    });

    // Background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });
    
    // terminated state
    FirebaseMessaging.onBackgroundMessage(doNothing);

    // get token
    String? token = await getToken();
    print(token);

  }

  // For use instant notification get(Locally)
  Future<String?> getToken() async{
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}


 // Top_level function for (terminated state)
 Future<void> doNothing(RemoteMessage message) async{
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
 }