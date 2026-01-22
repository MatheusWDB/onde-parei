import 'package:flutter/material.dart';
import 'package:onde_parei/components/list_component.dart';

final List<Map<String, dynamic>> ondePareiMock = [
  {
    'id': 1,
    'titulo': 'One Piece',
    'tipo': 'Anime',
    'temporada': 1,
    'episodio': 1080,
    'capitulo': 0,
    'pagina': 0,
    'concluido': false,
  },
  {
    'id': 2,
    'titulo': 'O Senhor dos Anéis',
    'tipo': 'Livro',
    'temporada': 0,
    'episodio': 0,
    'capitulo': 12,
    'pagina': 245,
    'concluido': false,
  },
  {
    'id': 3,
    'titulo': 'The Bear',
    'tipo': 'Série',
    'temporada': 2,
    'episodio': 4,
    'capitulo': 0,
    'pagina': 0,
    'concluido': false,
  },
  {
    'id': 4,
    'titulo': 'Batman: Ano Um',
    'tipo': 'HQ',
    'temporada': 0,
    'episodio': 0,
    'capitulo': 2,
    'pagina': 48,
    'concluido': false,
  },
  {
    'id': 5,
    'titulo': 'Berserk',
    'tipo': 'Mangá',
    'temporada': 0,
    'episodio': 0,
    'capitulo': 372,
    'pagina': 12,
    'concluido': false,
  },
];

class DashboardTab extends StatelessWidget {
  DashboardTab({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0,
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            prefixIcon: Icon(Icons.search),
            isDense: true,
            hintText: "Pesquisar obra...",
          ),
          style: TextStyle(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ondePareiMock.length,
            itemBuilder: (context, index) =>
                ListComponent(mock: ondePareiMock[index]),
          ),
        ),
      ],
    );
  }
}
