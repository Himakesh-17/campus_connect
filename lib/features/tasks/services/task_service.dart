import 'package:hive/hive.dart';
import '../models/task_model.dart';
import '../../notifications/services/notification_service.dart';

class TaskService {
  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;
  TaskService._internal();

  static const String _boxName = 'tasks_box';
  late Box<Map<dynamic, dynamic>> _box;
  final NotificationService _notificationService = NotificationService();

  Future<void> init() async {
    _box = await Hive.openBox<Map<dynamic, dynamic>>(_boxName);
  }

  List<TaskModel> getTasks() {
    return _box.values.map((map) => TaskModel.fromMap(map)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await _box.put(task.id, task.toMap());
    _scheduleTaskReminders(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await _box.put(task.id, task.toMap());
    await _notificationService.cancelNotification(task.notificationId);
    if (!task.completed) {
      _scheduleTaskReminders(task);
    }
  }

  Future<void> deleteTask(String id) async {
    final map = _box.get(id);
    if (map != null) {
      final task = TaskModel.fromMap(map);
      await _notificationService.cancelNotification(task.notificationId);
    }
    await _box.delete(id);
  }

  void _scheduleTaskReminders(TaskModel task) {
    if (task.completed) return;
    if (task.reminderMinutes > 0) {
      final reminderTime = task.dueDateTime.subtract(Duration(minutes: task.reminderMinutes));
      _notificationService.scheduleNotification(
        id: task.notificationId,
        title: 'Task Reminder: ${task.title}',
        body: 'Due in ${task.reminderMinutes} minutes',
        scheduledTime: reminderTime,
      );
    }
  }
}
