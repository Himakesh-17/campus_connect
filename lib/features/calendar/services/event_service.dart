import 'package:hive/hive.dart';
import '../models/event_model.dart';
import '../../notifications/services/notification_service.dart';

class EventService {
  static final EventService _instance = EventService._internal();
  factory EventService() => _instance;
  EventService._internal();

  static const String _boxName = 'events_box';
  late Box<Map<dynamic, dynamic>> _box;
  final NotificationService _notificationService = NotificationService();

  Future<void> init() async {
    _box = await Hive.openBox<Map<dynamic, dynamic>>(_boxName);
  }

  List<EventModel> getEvents() {
    return _box.values.map((map) => EventModel.fromMap(map)).toList();
  }

  Future<void> addEvent(EventModel event) async {
    await _box.put(event.id, event.toMap());
    _scheduleEventReminders(event);
  }

  Future<void> updateEvent(EventModel event) async {
    await _box.put(event.id, event.toMap());
    await _notificationService.cancelNotification(event.notificationId);
    _scheduleEventReminders(event);
  }

  Future<void> deleteEvent(String id) async {
    final map = _box.get(id);
    if (map != null) {
      final event = EventModel.fromMap(map);
      await _notificationService.cancelNotification(event.notificationId);
    }
    await _box.delete(id);
  }

  void _scheduleEventReminders(EventModel event) {
    if (event.reminderMinutes > 0) {
      final reminderTime = event.startDateTime.subtract(Duration(minutes: event.reminderMinutes));
      _notificationService.scheduleNotification(
        id: event.notificationId,
        title: 'Reminder: ${event.title}',
        body: 'Starts in ${event.reminderMinutes} minutes at ${event.location}',
        scheduledTime: reminderTime,
      );
    }
    // Also schedule exact time
    _notificationService.scheduleNotification(
      id: event.notificationId + 10000, // Offset for exact time
      title: '🚀 ${event.title} is starting now',
      body: 'Location: ${event.location}',
      scheduledTime: event.startDateTime,
    );
  }
}
