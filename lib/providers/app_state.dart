import 'package:flutter/material.dart';

import '../data/models/task.dart';

class AppState with ChangeNotifier {
  Task? _task;
  int appIndex = 1;

  final List<GlobalKey> keys = [];

  Map<int, Task> cache = {};

  AppState() {
    for (var i = 0; i < tasks.length; i++) {
      keys.add(GlobalKey());
    }
  }

  setCurrentTask(Task task, int index) {
    _task = task;
    notifyListeners();

    cache.putIfAbsent(appIndex++, () => task);
    notifyListeners();
  }

  Task get task => _task ?? tasks.first;

  Task? get previousTask {
    Task? task = cache.keys.length <= 1
        ? cache[cache.keys.length]
        : cache[cache.keys.length - 1];

    return task;
  }
}
