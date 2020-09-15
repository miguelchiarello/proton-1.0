import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proton/data/dummy_tasks.dart';
import 'package:proton/models/task.dart';

class Tasks with ChangeNotifier {
  static const _baseUrl = 'https://proton-f8866.firebaseio.com/';
  final Map<String, Task> _items = {...DUMMY_TASKS};

  List<Task> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Task byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future<void> put(Task task) async {
    if (task == null) {
      return;
    }

    if (task.id != null &&
        task.id.trim().isNotEmpty &&
        _items.containsKey(task.id)) {
      await http.patch(
        '$_baseUrl/tasks/${task.id}.json',
        body: json.encode(
          {
            'description': task.description,
            'priority': task.priority,
            'date': task.date,
            'hour': task.hour,
            'avatarUrl': task.avatarUrl,
          },
        ),
      );
      // Alterar.
      _items.update(
        task.id,
        (_) => Task(
          id: task.id,
          description: task.description,
          priority: task.priority,
          date: task.date,
          hour: task.hour,
          avatarUrl: task.avatarUrl,
        ),
      );
    } else {
      final response = await http.post(
        '$_baseUrl/tasks.json',
        body: json.encode(
          {
            'description': task.description,
            'priority': task.priority,
            'date': task.date,
            'hour': task.hour,
            'avatarUrl': task.avatarUrl,
          },
        ),
      );

      final id = json.decode(response.body)['name'];
      print(json.decode(response.body));
      // Adicionar.

      _items.putIfAbsent(
        id,
        () => Task(
          id: id,
          description: task.description,
          priority: task.priority,
          date: task.date,
          hour: task.hour,
          avatarUrl: task.avatarUrl,
        ),
      );
    }

    notifyListeners();
  }

  Future<void> remove(Task task) async {
    if (task != null && task.id != null) {
      await http.delete('$_baseUrl/tasks/${task.id}.json');
      _items.remove(task.id);
      notifyListeners();
    }
  }
}
