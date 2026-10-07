import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'screens/splash/splash_screen.dart';
import 'features/notifications/services/notification_service.dart';
import 'features/calendar/services/event_service.dart';
import 'features/tasks/services/task_service.dart';
import 'features/calendar/services/class_service.dart';
import 'screens/events/event_registration_service.dart';
import 'features/notifications/services/in_app_notification_service.dart';
import 'services/history_service.dart';
import 'services/settings_service.dart';
import 'screens/navigation/navigation_screen.dart';
import 'screens/navigation/destination_screen.dart';
import 'screens/navigation/map_screen.dart';
import 'screens/navigation/history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await NotificationService().init();
  await EventService().init();
  await TaskService().init();
  await ClassService().init();
  await EventRegistrationService().init();
  await InAppNotificationService().init();
  await HistoryService().init();
  await SettingsService().init();

  final initialMode = SettingsService().isDarkMode ? ThemeMode.dark : ThemeMode.light;
  runApp(CampusConnectApp(initialThemeMode: initialMode));
}

class CampusConnectApp extends StatefulWidget {
  final ThemeMode initialThemeMode;
  const CampusConnectApp({super.key, required this.initialThemeMode});

  /// Global key so Settings can toggle theme mode
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  State<CampusConnectApp> createState() => _CampusConnectAppState();
}

class _CampusConnectAppState extends State<CampusConnectApp> {
  @override
  void initState() {
    super.initState();
    CampusConnectApp.themeNotifier.value = widget.initialThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: CampusConnectApp.themeNotifier,
      builder: (_, themeMode, _) {
        return MaterialApp(
          title: AppConstants.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          routes: {
            '/navigation': (context) => const NavigationScreen(),
            '/destination': (context) => const DestinationScreen(),
            '/map': (context) => const MapScreen(),
            '/history': (context) => const HistoryScreen(),
          },
        );
      },
    );
  }
}
