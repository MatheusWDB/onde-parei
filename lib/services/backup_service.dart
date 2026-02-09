import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/repositories/work_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  final WorkRepository _repository = WorkRepository();

  Future<File> _generateBackupFile(Directory dir) async {
    final List<Work> works = await _repository.findAll();

    final List<String> jsonList = works.map((w) => w.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);

    final File file = File('${dir.path}/onde_parei_backup.json');
    await file.writeAsString(jsonString);

    return file;
  }

  Future<void> shareBackup() async {
    final Directory dir = await getTemporaryDirectory();
    final File file = await _generateBackupFile(dir);

    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<void> saveBackupToAppFolder() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    await _generateBackupFile(dir);
  }

  Future<List<Work>?> importBackup() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.files.single.path == null) return null;

    final File file = File(result.files.single.path!);
    final String jsonString = await file.readAsString();

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => Work.fromJson(e)).toList();
  }

  Future<List<Work>?> importFromAppFolder() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/onde_parei_backup.json');

    if (!await file.exists()) return null;

    final String jsonString = await file.readAsString();
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => Work.fromJson(e)).toList();
  }
}
