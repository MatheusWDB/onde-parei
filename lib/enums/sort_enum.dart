enum SortField {
  title('Título'),
  updatedAt('Atualização'),
  createdAt('Criação');

  final String displayName;
  
  const SortField(this.displayName);
}

enum SortDirection { asc, desc }
