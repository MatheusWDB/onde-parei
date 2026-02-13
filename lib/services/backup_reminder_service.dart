import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onde_parei/main.dart';
import 'package:onde_parei/models/app_settings.dart';
import 'package:timezone/timezone.dart' as tz;

class BackupReminderService {
  static const int _notificationId = 1001;
  static const _backupInterval = Duration(days: 5);
  static const _debugDelay = Duration(hours: 1);

  Future<void> scheduleIfNeeded(AppSettings settings) async {
    final now = DateTime.now();
    DateTime scheduleDate;

    if (settings.lastBackupAt == null) {
      scheduleDate = now.add(_backupInterval);
    } else {
      final nextBackup = settings.lastBackupAt!.add(_backupInterval);

      if (nextBackup.isBefore(now)) {
        scheduleDate = now.add(_debugDelay);
      } else {
        scheduleDate = nextBackup;
      }
    }

    await _schedule(scheduleDate);
  }

  Future<void> _schedule(DateTime date) async {
    const androidDetails = AndroidNotificationDetails(
      'backup_reminder',
      'Backup Reminder',
      channelDescription: 'Lembrete para fazer backup dos dados',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_notification_2',
      color: Color(0xFFF57C00),
    );

    const details = NotificationDetails(android: androidDetails);

    await notificationsPlugin.zonedSchedule(
      id: _notificationId,
      title: 'Hora de fazer backup',
      body: 'Não esqueça de salvar seus dados 😉',
      scheduledDate: tz.TZDateTime.from(date, tz.local),
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
    /** 
    await notificationsPlugin.show(
      id: _notificationId + 10,
      title: 'Teste de backup',
      body: 'Teste direto sem scheduler',
      notificationDetails: details,
    );
*/
    print('Notificação agendada para: $date');
  }

  Future<void> cancel() async {
    await notificationsPlugin.cancel(id: _notificationId);
  }
}
