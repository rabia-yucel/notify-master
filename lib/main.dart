import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notify/pages/dashboard/dashboard.dart';
import 'package:notify/pages/login.dart';
import 'package:notify/pages/splash.dart';
import 'package:notify/service/notification_data_manager.dart';


import 'firebase_options.dart';

/* testbr ?test ho
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //NotificationDataManager.saveNotification(message, "_firebaseMessagingBackgroundHandler");

}
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();


  // Set the background messaging handler early on, as a named top-level function
 // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) {
      if (message != null) {
          NotificationDataManager.saveNotification(message, "getInitialMessage");
      }
  });


  await initalizeCloudMessaging();

  FirebasePerformance performance = FirebasePerformance.instance;

  runApp(const MyApp());

}

Future<void> initalizeCloudMessaging() async {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    NotificationDataManager.subscribeToAllTopics();
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
    NotificationDataManager.subscribeToAllTopics();
  } else {
    print('User declined or has not accepted permission');
  }

  /*
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationDataManager.saveNotification(message, "onMessage");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    NotificationDataManager.saveNotification(message, "onMessageOpenedApp");
  });
  */
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const Splash(),
        '/login': (context) => const Login(),
        '/dashboard': (context) => const Dashboard(),
      },
    );

  }
}


