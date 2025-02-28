import 'dart:convert';
import 'package:batchiq_app/core/services/generate_access_token.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// request permission
    await _requestPermission();

    /// setup message handlers
    await _setupMessageHandlers();

    /// get fcm token
    final token = await _messaging.getToken();
    debugPrint("FCM Token: $token");
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    debugPrint("Permission status: ${settings.authorizationStatus}");
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    const channel = AndroidNotificationChannel(
      "high_important_channel",
      "High Important Notifications",
      description: "This channel is used for important notifications.",
      importance: Importance.high,
    );

    await _localNotification
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              "high_important_channel", "High Important Notifications",
              channelDescription: "This channel is used for important notifications.",
              importance: Importance.high,
              priority: Priority.high,
              icon: "@mipmap/ic_launcher"),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    /// foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    /// background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    /// opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'notification') {
      /// open notification screen
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    debugPrint("Subscribed to: $topic");
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    debugPrint("Unsubscribed from: $topic");
  }

  Future<void> sendFcmNotification({
    required String title,
    required String body,
    required String topic,
  }) async {
    final accessToken = await AccessTokenGenerator.generateAccessToken();
    try {
      final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/v1/projects/batchiq-app/messages:send"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
          {
            "message": {
              "topic": topic,
              "notification": {"body": body, "title": title},
              "data": {"type": "notification"}
            }
          },
        ),
      );

      debugPrint('Notification sent: ${response.body}');
    } catch (e) {
      debugPrint("Error sending notification: $e");
    }
  }
}