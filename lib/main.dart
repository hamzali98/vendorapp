import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendor_app/res/getx_localization/languages.dart';
import 'package:vendor_app/res/routes/routes.dart';
import 'package:vendor_app/res/routes/routes_name.dart';
import 'package:vendor_app/view_models/controller/create_new_drop_off/create_newdropoff_order_view_model.dart';
import 'package:vendor_app/view_models/controller/create_new_drop_off/search_user_by_phone_view_model.dart';
import 'package:vendor_app/view_models/controller/drop_off/drop_off_view_model.dart';
import 'package:vendor_app/view_models/controller/home/Tabs/notification_controller.dart';
import 'dart:io' show Platform;

// Firebase background handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");

  if (message.notification != null) {
    Get.find<NotificationController>().incrementNotificationCount(
      data: {
        'title': message.notification?.title ?? 'No title',
        'body': message.notification?.body ?? 'No body',
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBUrj4vodFE5spdc1S_DcBGk-vGQ7UCDQc",
        authDomain: "vendor-app-c249d.firebaseapp.com",
        projectId: "vendor-app-c249d",
        storageBucket: "vendor-app-c249d.appspot.com",
        messagingSenderId: "85528175451",
        appId: "1:85528175451:web:f2aadad828af267152307e",
        measurementId: "G-36XC5F20Y3",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  await GetStorage.init();
  await setupFirebaseMessaging();

  Get.lazyPut(() => SearchUserByPhoneController(), fenix: true);
  Get.lazyPut(() => ListDropoffController(), fenix: true);
  Get.lazyPut(() => CreateDropOffOrderViewModel(), fenix: true);
  Get.lazyPut(() => NotificationController(), fenix: true);

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    FirebaseMessaging.instance.subscribeToTopic("all");
  }

  runApp(const VendorApp());
}

Future<void> setupFirebaseMessaging() async {
  try {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (kIsWeb) {
      String? token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BEmQk1b-kVYxs-4hP7DUsZ1xC--CrzEbMPV3DecCFxcxEzS3x5Ty8oRFJEJbx81KpwI55JK_FynKjWhmCJSxFHc",
      );
      print('FCM Token: $token');

      if (token != null) {
        final box = GetStorage();
        box.write('fcm_token', token);
      }
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.data}');

      final controller = Get.find<NotificationController>();
      controller.incrementNotificationCount(
        data: {
          'title': message.notification?.title ?? 'No title',
          'body': message.notification?.body ?? 'No body',
        },
      );

      if (kIsWeb && message.notification != null) {
        Get.snackbar(
          message.notification?.title ?? 'New Notification',
          message.notification?.body ?? '',
          icon: const Icon(Icons.notifications),
          duration: const Duration(seconds: 5),
        );
      }
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationNavigation(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationNavigation);
  } catch (e) {
    print('Error setting up Firebase Messaging: $e');
  }
}

void _handleNotificationNavigation(RemoteMessage message) {
  final controller = Get.find<NotificationController>();
  controller.incrementNotificationCount(
    data: {
      'title': message.notification?.title ?? 'No title',
      'body': message.notification?.body ?? 'No body',
    },
  );

  if (message.data['type'] == 'new_order') {
    Get.toNamed(RouteName.newOrderScreen);
  } else {
    Get.toNamed(RouteName.notificationScreen);
  }
}

class VendorApp extends StatelessWidget {
  const VendorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Languages(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        initialRoute: RouteName.splashScreen,
        getPages: AppRoutes.appRoutes(),
      ),
    );
  }
}
