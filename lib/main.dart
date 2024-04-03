import 'package:careio_doctor_version/LifeCycleController.dart';
import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Pages/splash/splashPage.dart';
import 'package:careio_doctor_version/Routing/app_routes.dart';
import 'package:careio_doctor_version/Services/BindingService/bindings.dart';
import 'package:careio_doctor_version/Services/NotificationService/notification_service_handler.dart';
import 'package:careio_doctor_version/Theme/theme_provider.dart';
import 'package:careio_doctor_version/Constants/appointment_enum.dart';
import 'package:careio_doctor_version/Utils/scroll_behavior.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // NotificationServiceHandler.showLocalNotification(message.notification!.toMap());
  if(message.data['status'] != null && message.data['status'] == AppointmentStatus.accepted){
    // NotificationServiceHandler.scheduleLocalNotification(message.data);
  }

}

void main() async {
  NotificationServiceHandler.initializeFirebase();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  Get.put(LifeCycleController(), permanent: true);
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          GetMaterialApp(
        title: 'Careio Plus',
        theme: ThemeProvider.lightTheme,
        initialBinding: BindingService(),
        scrollBehavior: const ScrollBehaviorModified(),
        getPages: AppRoutes.allRoutes,
        fallbackLocale: const Locale("en", "US"),
        debugShowCheckedModeBanner: false,
        translations: LocalizationHelper(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        home: const SplashPage(),
      ),
    );
  }
}
