# 📖 Onde Parei? 
[![NPM](https://img.shields.io/npm/l/react)](https://github.com/MatheusWDB/onde-parei/blob/main/LICENSE)

# Sobre o projeto
**Onde Parei?** é uma aplicação mobile desenvolvida com Flutter para ajudar entusiastas de leitura e entretenimento a organizar seu progresso em diferentes tipos de obras. O sistema permite o registro detalhado de livros, mangás, HQs e filmes, garantindo que o usuário nunca esqueça em qual capítulo ou página parou.

O projeto conta com armazenamento local seguro, sistema de busca avançado, ordenação personalizada e funcionalidades de backup para garantir a persistência dos dados.

## Funcionalidades:
* **Gerenciamento de Obras:** Cadastrar, editar e excluir registros de livros, mangás, HQs e filmes.
* **Controle de Progresso:** Atualização rápida do capítulo ou página atual.
* **Categorização:** Filtros por tipo de obra para facilitar a navegação.
* **Busca e Ordenação:** Localização rápida de títulos e organização por nome ou data de atualização.
* **Configurações Personalizadas:** Escolha de temas e preferências de exibição.
* **Sistema de Backup:** Exportação e importação de dados para segurança das informações.
* **Interface Responsiva:** Design intuitivo com suporte a Dark Mode e temas dinâmicos.

# Recursos
* **Banco de Dados Local:** Utilização do SQLite para armazenamento offline persistente.
* **Gerenciamento de Estado:** Uso de `Riverpod` com geração de código (`riverpod_generator`) para um estado reativo e eficiente.
* **Feedback Visual:** Diálogos de confirmação para exclusões e SnackBar para notificações de sucesso/erro.
* **Backup via JSON:** Estrutura robusta para salvar e restaurar o banco de dados.

# Sumário
-	[Tecnologias Utilizadas](#-tecnologias-utilizadas)
-	[Instalação](#%EF%B8%8F-instalação)  
    - [Pré-requisitos](#pré-requisitos)
    - [Configuração do Frontend](#configuração)    
-	[Uso da Aplicação](#-uso-da-aplicação)
-	[Capturas de Tela/GIFs](#%EF%B8%8F-capturas-de-telagifs)
-	[Autores](#%E2%80%8D-autor)

________________________________________
# 💻 Tecnologias Utilizadas

## Mobile

* **Flutter** (Framework)
* **Dart** (Linguagem)

## Bibliotecas Principais (Dependências)

* **sqflite:** Banco de dados relacional local.
* **flutter_riverpod:** Gerenciamento de estado moderno.
* **path_provider:** Acesso ao sistema de arquivos para backups.
* **intl:** Formatação de datas e internacionalização.
* **permission_handler:** Gerenciamento de permissões de armazenamento.
________________________________________
# 🛠️ Instalação

### Pré-requisitos:

* Flutter SDK instalado (versão estável mais recente).
* Dispositivo Android/iOS ou Emulador configurado.

### Configuração:

1. **Clonar o repositório:**
```bash
git clone https://github.com/seu-usuario/onde-parei.git
cd onde_parei
```

2. **Instalar as dependências:**
```bash
flutter pub get
```

3. **Gerar arquivos automáticos (Riverpod):**
```bash
flutter pub run build_runner build
```

4. **Executar a aplicação:**
```bash
flutter run
```
________________________________________
# 🏃 Uso da Aplicação

Após iniciar o aplicativo, você pode:

1. **Adicionar uma obra:** Clique no botão "+" na tela inicial, preencha o título, selecione o tipo (Livro, Mangá, etc.) e defina o capítulo inicial.
2. **Atualizar progresso:** Clique em um item da lista para editar o progresso ou outras informações.
3. **Escluir ou Arquivar uma obra:** Segure em um item da lista para mostar as opções disponíveis.
4. **Pesquisar obra:** Utilize o campo para pesquisar uma obra específica.
5. **Ordenar:** Use o menu superior para ordenar as obras por título, ou data de criação.
6. **Backup:** Vá em "Configurações" para exportar seus dados para compartilhar o arquivo .json com os dados salvos.
________________________________________
# 🖼️ Capturas de Tela/GIFs
| Home Screen | Add/Update Work | Settings |
|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|
| ![0](https://github.com/user-attachments/assets/75c28999-6321-481c-a1a1-eca55448d398) | ![1](https://github.com/user-attachments/assets/47408e2a-3ad4-4e7b-8235-a8bff554971b) | ![2](https://github.com/user-attachments/assets/5cea5829-0705-4e56-bfe8-971f03451715) |
| ![3](https://github.com/user-attachments/assets/3d241499-3fb7-4444-afb1-401540803c32) | ![4](https://github.com/user-attachments/assets/60e6db55-5da2-440f-ab25-55c5da34f33a) | ![5](https://github.com/user-attachments/assets/a8368fb3-a770-4af8-95b3-967a8958dc7e)|
________________________________________
## 🧑‍💻 Autor

###	Matheus Wendell Dantas Bezerra

- [LinkedIn](https://www.linkedin.com/in/mwdb1703)
- [Portfólio]( https://matheus-wendell.onrender.com/)
