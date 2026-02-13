import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/enums/app_theme_mode_enum.dart';
import 'package:onde_parei/l10n/app_localizations.dart';
import 'package:onde_parei/l10n/l10n.dart';
import 'package:onde_parei/providers/settings_provider.dart';
import 'package:onde_parei/screens/home_screen.dart';
import 'package:onde_parei/theme/app_themes.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

  const android = AndroidInitializationSettings('ic_notification_2');
  const settings = InitializationSettings(android: android);

  await notificationsPlugin.initialize(settings: settings);

  await notificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.whereDidIStop,
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode.toThemeMode(),
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      home: const HomeScreen(),
    );
  }
}
