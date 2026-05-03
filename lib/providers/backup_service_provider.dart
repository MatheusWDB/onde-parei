import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/services/backup_reminder_service.dart';
import 'package:onde_parei/services/backup_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_service_provider.g.dart';

@Riverpod(keepAlive: true)
BackupService backupService(Ref ref) =>
    BackupService(repository: ref.read(workRepositoryProvider));

@Riverpod(keepAlive: true)
BackupReminderService backupReminderService(Ref _) => BackupReminderService();
