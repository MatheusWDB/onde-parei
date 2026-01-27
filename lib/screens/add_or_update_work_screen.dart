import 'package:flutter/material.dart';
import 'package:onde_parei/enums/type_enum.dart';
import 'package:onde_parei/models/work.dart';

class AddOrUpdateWorkScreen extends StatefulWidget {
  final Work? work;

  const AddOrUpdateWorkScreen({super.key, this.work});

  @override
  State<AddOrUpdateWorkScreen> createState() => _AddOrUpdateWorkScreenState();
}

class _AddOrUpdateWorkScreenState extends State<AddOrUpdateWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _seasonOrChapterController = TextEditingController();
  final _episodeOrPageController = TextEditingController();

  TypeEnum _selectedType = TypeEnum.series;

  @override
  void initState() {
    super.initState();
    if (widget.work != null) {
      _titleController.text = widget.work!.title;
      _seasonOrChapterController.text = widget.work!.isReadingType
          ? widget.work!.chapter.toString()
          : widget.work!.season.toString();
      _episodeOrPageController.text = widget.work!.isReadingType
          ? widget.work!.page.toString()
          : widget.work!.episode.toString();
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.work == null ? 'Nova Obra' : 'Editar')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8.0,
                  children: [
                    Column(
                      children: [
                        Text('Título da Obra'),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Harry Potter',
                            labelText: widget.work?.title,
                            errorMaxLines: 2,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Categoria'),
                        DropdownMenu<TypeEnum>(
                          initialSelection: _selectedType,
                          onSelected: (value) {
                            setState(() {
                              _selectedType = value!;
                            });
                          },
                          dropdownMenuEntries: TypeEnum.values
                              .map(
                                (e) => DropdownMenuEntry(
                                  value: e,
                                  label: e.displayName,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                _selectedType.isVideo ? 'Temporada' : 'Capítulo',
                              ),
                              TextFormField(
                                controller: _seasonOrChapterController,
                                decoration: InputDecoration(
                                  hintText: widget.work == null
                                      ? '0'
                                      : widget.work!.isFinished
                                      ? widget.work!.chapter.toString()
                                      : widget.work!.season.toString(),
                                  errorMaxLines: 2,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  hintStyle: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(_selectedType.isVideo ? 'Episódio' : 'Página'),
                              TextFormField(
                                controller: _episodeOrPageController,
                                decoration: InputDecoration(
                                  hintText: widget.work == null
                                      ? '0'
                                      : widget.work!.isFinished
                                      ? widget.work!.page.toString()
                                      : widget.work!.episode.toString(),
                                  errorMaxLines: 2,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  hintStyle: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [Icon(Icons.save), Text('Guardar Alterações')],
                    ),
                  ),
                  if (widget.work != null)
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.delete_forever),
                          Text('Eliminar Obra'),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
