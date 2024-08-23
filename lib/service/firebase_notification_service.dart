import 'package:firebase_messaging/firebase_messaging.dart';

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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print(message.notification?.title);
          print(message.notification?.body);
          print(message.data);
    });

    // Background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });
    
    // terminated state
    FirebaseMessaging.onBackgroundMessage(doNothing);

  }
}


 // Top_level function for (terminated state)
 Future<void> doNothing(RemoteMessage message) async{
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
 }