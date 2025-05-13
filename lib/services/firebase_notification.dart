import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:tfb/views/SingleHouseboat/single_houseboat.dart';
import 'package:tfb/views/SingleTour/single_tour.dart';
import '../firebase_options.dart';

class NotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Android: local notification channel setup
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        _handleNotificationTap(payload);
      },
    );

    // Background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Ask for permission
    await _firebaseMessaging.requestPermission();

    // Get FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");

    // Foreground notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');
      showLocalNotification(message);
    });

    // Tapped notification when app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final type = message.data['type'];
      final id = message.data['id'];
      _handleNotificationTap('type=$type&id=$id');
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Background message: ${message.messageId}');
  }

  static void showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      final androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        // 👇 Optional: show image in notification (foreground only)
        styleInformation: BigPictureStyleInformation(
          DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        ),
      );

      final details = NotificationDetails(android: androidDetails);

      // 👇 Combine type and id into a string payload
      final payload = 'type=${message.data['type']}&id=${message.data['id']}';

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        details,
        payload: payload,
      );
    }
  }

  static void _handleNotificationTap(String? payload) {
    if (payload == null) return;

    try {
      final data = Uri.splitQueryString(payload);
      final type = data['type'];
      final id = data['id'];

      switch (type) {
        case 'houseboat':
          if (id != null) {
            Get.to(() => SingleHouseboat(houseboatSlug: id));
          }
          break;
        case 'tour':
          if (id != null) {
            Get.to(() => SingleTour(slug: id));
          }
          break;
        case 'booking':
          print("Navigate to Booking Screen with ID $id");
          break;
        default:
          print("Navigate to General Notification Screen");
      }
    } catch (e) {
      print("Error parsing payload: $e");
    }
  }
}
