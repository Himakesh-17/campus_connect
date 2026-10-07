import re

content = open('lib/services/history_service.dart').read()

content = content.replace("import 'package:hive/hive.dart';", "import 'package:hive/hive.dart';\nimport 'package:flutter/foundation.dart';")
content = content.replace('class HistoryService {', 'class HistoryService extends ChangeNotifier {')

content = re.sub(r'(await _box\.put\([^\)]+\);)', r'\1\n    notifyListeners();', content)
content = re.sub(r'(await _box\.delete\([^\)]+\);)', r'\1\n    notifyListeners();', content)
content = re.sub(r'(await _box\.clear\(\);)', r'\1\n    notifyListeners();', content)

open('lib/services/history_service.dart', 'w').write(content)
