import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/repositories/work_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  final WorkRepository _repository = WorkRepository();

  Future<File> exportBackup() async {
    final works = await _repository.findAll();

    final jsonList = works.map((w) => w.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/onde_parei_backup.json');

    await file.writeAsString(jsonString);

    return file;
  }

  Future<void> shareBackup() async {
    final file = await exportBackup();
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<List<Work>?> importBackup(WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);
    final jsonString = await file.readAsString();

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => Work.fromJson(e)).toList();
  }
}
