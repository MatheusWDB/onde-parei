import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/enums/type_enum.dart';
import 'package:onde_parei/l10n/app_localizations.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/work_list_provider.dart';

class AddOrUpdateWorkScreen extends ConsumerStatefulWidget {
  final Work? work;

  const AddOrUpdateWorkScreen({super.key, this.work});

  @override
  ConsumerState<AddOrUpdateWorkScreen> createState() =>
      _AddOrUpdateWorkScreenState();
}

class _AddOrUpdateWorkScreenState extends ConsumerState<AddOrUpdateWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _seasonOrChapterController = TextEditingController();
  final _episodeOrPageController = TextEditingController();
  TypeEnum _selectedType = TypeEnum.series;

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    HapticFeedback.mediumImpact();

    final listNotifier = ref.read(workListProvider.notifier);

    final isEditing = widget.work != null;

    final work = Work(
      title: _titleController.text.trim(),
      type: _selectedType,
      season: _selectedType.isVideo
          ? int.tryParse(_seasonOrChapterController.text) ?? 1
          : 1,
      episode: _selectedType.isVideo
          ? int.tryParse(_episodeOrPageController.text) ?? 1
          : 1,
      chapter: _selectedType.isReading
          ? double.tryParse(_seasonOrChapterController.text) ?? 1.0
          : 1.0,
      page: _selectedType.isReading
          ? int.tryParse(_episodeOrPageController.text) ?? 1
          : 1,
      isFinished: widget.work?.isFinished ?? false,
      createdAt: widget.work?.createdAt,
      updatedAt: DateTime.now(),
    );

    isEditing
        ? listNotifier.updateWork(work.copyWith(id: widget.work!.id))
        : listNotifier.addWork(work);

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if (widget.work != null) {
      final work = widget.work!;

      _titleController.text = work.title;
      _selectedType = work.type;

      _seasonOrChapterController.text = work.isReadingType
          ? work.chapter.toString()
          : work.season.toString();

      _episodeOrPageController.text = work.isReadingType
          ? work.page.toString()
          : work.episode.toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _seasonOrChapterController.dispose();
    _episodeOrPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.work == null ? t.newWork : t.edit,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 25.0,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 20.0,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.titleOfWork),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: t.exampleTitle,
                            errorMaxLines: 2,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            hintStyle: const TextStyle(fontSize: 14.0),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe um título';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.category),
                        DropdownMenu<TypeEnum>(
                          initialSelection: _selectedType,
                          width: double.infinity,
                          onSelected: (value) {
                            setState(() {
                              _selectedType = value!;
                            });
                          },
                          dropdownMenuEntries: TypeEnum.values
                              .map(
                                (e) => DropdownMenuEntry(
                                  value: e,
                                  label: e.displayName(t),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 20.0,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedType.isVideo
                                    ? t.season
                                    : t.chapter,
                              ),
                              TextFormField(
                                controller: _seasonOrChapterController,
                                decoration: InputDecoration(
                                  hintText: widget.work == null
                                      ? t.zero
                                      : widget.work!.isReadingType
                                      ? widget.work!.chapter.toString()
                                      : widget.work!.season.toString(),
                                  errorMaxLines: 2,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  hintStyle: const TextStyle(fontSize: 14.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!_selectedType.isReading ||
                                  _selectedType == TypeEnum.book) ...[
                                Text(
                                  _selectedType.isVideo ? t.episode : t.page,
                                ),
                                TextFormField(
                                  controller: _episodeOrPageController,
                                  decoration: InputDecoration(
                                    hintText: widget.work == null
                                        ? t.zero
                                        : widget.work!.isReadingType
                                        ? widget.work!.page.toString()
                                        : widget.work!.episode.toString(),
                                    errorMaxLines: 2,
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    hintStyle: const TextStyle(fontSize: 14.0),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _save,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.save),
                    Text(t.saveChanges),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
