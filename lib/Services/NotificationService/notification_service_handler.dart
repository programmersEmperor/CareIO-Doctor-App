import 'dart:math';
import 'package:careio_doctor_version/Pages/Home/controller/appointment_controller.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:careio_doctor_version/Utils/appointment_enum.dart';
import 'package:careio_doctor_version/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;




abstract class NotificationServiceHandler {
  static late FirebaseMessaging messaging;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    messaging = FirebaseMessaging.instance;
    Get.put(UserSession(), permanent: true);
    Get.find<UserSession>().firebaseDeviceToken =
        await messaging.getToken() ?? "";

    if (await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false) {
      _configureLocalNotifications();
    }
  }

  static Future<void> _configureLocalNotifications() async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/careio_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {

      },
    );
    _configureFirebaseMessaging();
  }

  static void _configureFirebaseMessaging() {
    try {
      FirebaseMessaging.onMessage.listen((event) {
        final AppointmentController appointmentController = Get.put(AppointmentController());
        appointmentController.initializeAppointments(status: AppointmentTypes.upcoming);
        showLocalNotification(event.notification!.toMap(), event.data);
        if (event.data['status'] != null) {
          if (event.data['status'] == AppointmentStatus.accepted.index.toString()) {
            scheduleLocalNotification(event.data);
          }
          else if (event.data['status'] == AppointmentStatus.rejected.index.toString()) {
            unscheduleLocalNotification(event.data['id']);
          }
        }
      });
    }
    catch(e){
      debugPrint("notification error ${e.toString()}");
    }
  }

  static void unscheduleLocalNotification(int id) async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static void scheduleLocalNotification(Map<String, dynamic> data) async{
    try{
      debugPrint("scheduleLocalNotification at :${tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)).toString()}");
      debugPrint("scheduleLocalNotification at :${tz.TZDateTime.now(tz.local).toString()}");
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'all-notifications-channel',
        'all-notifications',
        channelDescription: 'all-notifications-description',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@drawable/careio_launcher',
        largeIcon: DrawableResourceAndroidBitmap('@drawable/careio_launcher'),
        channelShowBadge: true,
        enableLights: true,
        enableVibration: true,
        playSound: true,
      );
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
          int.parse(data['id']),
          Get.locale.toString() == 'ar_AR'? data['sTitleAr'] : data['sTitleEn'],
          Get.locale.toString() == 'ar_AR'? data['sBodyAr'] : data['sBodyEn'],
          tz.TZDateTime.from(DateTime.parse('${data['date']} ${data['time']}'), tz.local).subtract(Duration(days: 1)),
          // tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
          platformChannelSpecifics,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
    }
    catch (e){
      debugPrint("scheduleLocalNotification error ${e.toString()}");
    }

  }

  static void showLocalNotification(Map<String, dynamic> message, Map<String, dynamic> data) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'all-notifications-channel',
      'all-notifications',
      channelDescription: 'all-notifications-description',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/careio_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@drawable/careio_launcher'),
      channelShowBadge: true,
      enableLights: true,
      enableVibration: true,
      playSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    Random random = Random();
    int uniqueId = random.nextInt(999999);

    await flutterLocalNotificationsPlugin.show(
      uniqueId, // Notification ID
      Get.locale.toString() == 'ar_AR'? data['titleAr'] : data['titleEn'], // Notification title
      Get.locale.toString() == 'ar_AR'? data['bodyAr'] : data['bodyEn'], // Notification body
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}
