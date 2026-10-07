import 'package:hive/hive.dart';

/// Persists user preferences using Hive.
/// Firebase-ready: swap implementation without changing UI.
class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  static const String _boxName = 'settings_box';
  late Box<dynamic> _box;

  Future<void> init() async {
    _box = await Hive.openBox<dynamic>(_boxName);
  }

  // ── Getters ─────────────────────────────────────────────────────────────

  bool get isDarkMode => _box.get('dark_mode', defaultValue: false) as bool;
  bool get notificationsEnabled => _box.get('notifications_enabled', defaultValue: true) as bool;
  bool get taskRemindersEnabled => _box.get('task_reminders', defaultValue: true) as bool;
  bool get eventRemindersEnabled => _box.get('event_reminders', defaultValue: true) as bool;
  bool get soundEnabled => _box.get('sound_enabled', defaultValue: true) as bool;
  bool get hapticEnabled => _box.get('haptic_enabled', defaultValue: true) as bool;

  // ── Setters ─────────────────────────────────────────────────────────────

  Future<void> setDarkMode(bool v) async => await _box.put('dark_mode', v);
  Future<void> setNotificationsEnabled(bool v) async => await _box.put('notifications_enabled', v);
  Future<void> setTaskReminders(bool v) async => await _box.put('task_reminders', v);
  Future<void> setEventReminders(bool v) async => await _box.put('event_reminders', v);
  Future<void> setSoundEnabled(bool v) async => await _box.put('sound_enabled', v);
  Future<void> setHapticEnabled(bool v) async => await _box.put('haptic_enabled', v);
}
