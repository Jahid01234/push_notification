import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification_with_firebase/firebase_options.dart';
import 'package:push_notification_with_firebase/service/firebase_notification_service.dart';
import 'package:push_notification_with_firebase/ui/home_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async {

  //Firebase Initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await FirebaseNotificationService.instance.initialize();

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      title: 'Flutter Push Notification',
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}


