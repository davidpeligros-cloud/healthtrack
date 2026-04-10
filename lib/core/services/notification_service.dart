import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseMessaging _firebaseMessaging;

  NotificationService()
      : _localNotifications = FlutterLocalNotificationsPlugin(),
        _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
  }

  Future<void> scheduleMealReminder({
    required int id,
    required String mealType,
    required TimeOfDay time,
    required String locale,
  }) async {
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _localNotifications.zonedSchedule(
      id: id,
      title: _getMealReminderTitle(mealType, locale),
      body: _getMealReminderBody(mealType, locale),
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'meal_reminders',
          'Recordatorios de comidas',
          channelDescription: 'Recordatorios para registrar tus comidas',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_notification',
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'meal_reminder:$mealType',
    );
  }

  Future<void> cancelMealReminder(int id) async {
    await _localNotifications.cancel(id: id);
  }

  Future<void> cancelAllReminders() async {
    await _localNotifications.cancelAll();
  }

  String _getMealReminderTitle(String mealType, String locale) {
    final titles = {
      'en': {
        'breakfast': '🌅 Breakfast time!',
        'lunch': '☀️ Lunch time!',
        'dinner': '🌙 Dinner time!',
        'snack': '🍎 Snack time!',
      },
      'es': {
        'breakfast': '🌅 ¡Hora del desayuno!',
        'lunch': '☀️ ¡Hora de comer!',
        'dinner': '🌙 ¡Hora de cenar!',
        'snack': '🍎 ¡Hora del snack!',
      },
      'ca': {
        'breakfast': '🌅 Hora d\'esmorzar!',
        'lunch': '☀️ Hora de dinar!',
        'dinner': '🌙 Hora de sopar!',
        'snack': '🍎 Hora del berenar!',
      },
    };

    return titles[locale]?[mealType] ?? titles['en']![mealType]!;
  }

  String _getMealReminderBody(String mealType, String locale) {
    final bodies = {
      'en': "Don't forget to log your $mealType",
      'es': 'No olvides registrar tu comida',
      'ca': 'No oblidis registrar el teu àpat',
    };
    return bodies[locale] ?? bodies['en']!;
  }

  void _onNotificationTap(NotificationResponse response) {
    // Implementar navegación según payload
  }
}
