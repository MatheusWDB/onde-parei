import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/repositories/work_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  final WorkRepository _repository;

  BackupService({required WorkRepository repository}) : _repository = repository;

  static const _backupName = 'onde_parei_backup';

  Future<String> _generateBackupJson() async {
    final works = await _repository.findAll();
    return jsonEncode(works.map((w) => w.toJson()).toList());
  }

  Future<File> _generateBackupFile(Directory dir) async {
    final now = DateTime.now().toIso8601String().replaceAll(':', '-');
    final file = File('${dir.path}/${_backupName}_$now.dat');
    final jsonString = await _generateBackupJson();

    await file.writeAsString(jsonString);
    return file;
  }

  Future<void> shareBackup() async {
    final Directory dir = await getTemporaryDirectory();
    final File file = await _generateBackupFile(dir);

    final result = await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: 'Backup Onde Parei?'),
    );

    if (result.status == ShareResultStatus.dismissed) {
      throw const BackupCancelledException();
    }
  }

  Future<void> saveBackup() async {
    final dir = await getTemporaryDirectory();
    final file = await _generateBackupFile(dir);

    final bytes = await file.readAsBytes();
    final now = DateTime.now().toIso8601String().replaceAll(':', '-');

    final path = await FileSaver.instance.saveAs(
      name: '${_backupName}_$now',
      bytes: bytes,
      fileExtension: 'dat',
      mimeType: MimeType.other,
    );

    if (path == null || path.isEmpty) {
      throw const BackupCancelledException();
    }
  }

  Future<List<Work>?> importBackup() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['dat', 'json'],
    );

    if (result == null || result.files.single.path == null) return null;

    final File file = File(result.files.single.path!);
    final String jsonString = await file.readAsString();

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => Work.fromJson(e)).toList();
  }
}

class BackupCancelledException implements Exception {
  const BackupCancelledException();
}
