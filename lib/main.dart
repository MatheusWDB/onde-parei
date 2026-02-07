import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/enums/app_theme_mode_enum.dart';
import 'package:onde_parei/providers/settings_provider.dart';
import 'package:onde_parei/screens/home_screen.dart';
import 'package:onde_parei/theme/app_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    
    return MaterialApp(
      title: 'Onde Parei?',
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode.toThemeMode(),
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      home: const HomeScreen(),
    );
  }
}
