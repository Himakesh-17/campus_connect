import 'package:hive/hive.dart';
import '../models/class_model.dart';

class ClassService {
  static final ClassService _instance = ClassService._internal();
  factory ClassService() => _instance;
  ClassService._internal();

  static const String _boxName = 'classes_box';
  late Box<Map<dynamic, dynamic>> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Map<dynamic, dynamic>>(_boxName);
  }

  List<ClassModel> getClasses() {
    return _box.values.map((map) => ClassModel.fromMap(map)).toList();
  }

  Future<void> addClass(ClassModel cls) async {
    await _box.put(cls.id, cls.toMap());
  }

  Future<void> deleteClass(String id) async {
    await _box.delete(id);
  }

  /// Returns all classes that occur on [date].
  List<ClassModel> getClassesForDate(DateTime date) {
    return getClasses().where((cls) => cls.occursOn(date)).toList();
  }
}
