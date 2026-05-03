import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onde_parei/main.dart';
import 'package:onde_parei/models/app_settings.dart';
import 'package:timezone/timezone.dart' as tz;

class BackupReminderService {
  static const int _singleId = 1001;
  static const int _periodicBaseId = 1002;

  static const int _periodicCount = 6;

  static const _interval = Duration(days: 5);

  static const _androidDetails = AndroidNotificationDetails(
    'backup_reminder',
    'Backup Reminder',
    channelDescription: 'Lembrete para fazer backup dos dados',
    importance: Importance.high,
    priority: Priority.high,
    icon: 'ic_notification_2',
    color: Color(0xFFF57C00),
  );

  static const _details = NotificationDetails(android: _androidDetails);

  Future<void> scheduleFromSettings(
    AppSettings settings, {
    required String title,
    required String body,
  }) async {
    await cancel();

    final now = DateTime.now();
    final DateTime singleFireDate;

    final lastBackup = settings.lastBackupAt;
    final Duration difference = now.difference(lastBackup ?? now);
    if (lastBackup == null || difference >= _interval) {
      singleFireDate = now.add(const Duration(seconds: 2));
    } else {
      singleFireDate = now.add(_interval - difference);
    }

    await _scheduleOne(
      id: _singleId,
      title: title,
      body: body,
      date: singleFireDate,
    );
    await _schedulePeriodic(
      title: title,
      body: body,
      firstDate: singleFireDate.add(_interval),
    );
  }

  Future<void> rescheduleAfterBackup(
    DateTime backupDate, {
    required String title,
    required String body,
  }) async {
    await cancel();

    final singleFireDate = backupDate.add(_interval);

    await _scheduleOne(
      id: _singleId,
      title: title,
      body: body,
      date: singleFireDate,
    );
    await _schedulePeriodic(
      title: title,
      body: body,
      firstDate: singleFireDate.add(_interval),
    );
  }

  Future<void> cancel() async {
    await notificationsPlugin.cancel(id: _singleId);
    for (int i = 0; i < _periodicCount; i++) {
      await notificationsPlugin.cancel(id: _periodicBaseId + i);
    }
  }

  Future<void> _schedulePeriodic({
    required String title,
    required String body,
    required DateTime firstDate,
  }) async {
    for (int i = 0; i < _periodicCount; i++) {
      await _scheduleOne(
        id: _periodicBaseId + i,
        title: title,
        body: body,
        date: firstDate.add(_interval * i),
      );
    }
  }

  Future<void> _scheduleOne({
    required int id,
    required String title,
    required String body,
    required DateTime date,
  }) async {
    await notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(date, tz.local),
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }
}
