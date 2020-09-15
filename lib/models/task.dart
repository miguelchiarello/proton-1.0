import 'package:flutter/material.dart';

class Task {
  final String id;
  final String description;
  final String priority;
  final String date;
  final String hour;
  final String avatarUrl;

  const Task({
    this.id,
    @required this.description,
    @required this.priority,
    @required this.date,
    @required this.hour,
    @required this.avatarUrl,
  });

  void remove(Task task) {}
}
