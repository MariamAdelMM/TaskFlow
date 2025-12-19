import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

enum TaskCategory { work, home, study }

class Task {
  //These are fields (properties) of the Task class
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final TaskCategory category;
  final TaskPriority priority;
  bool isCompleted;

  // This is the constructor. It runs when you create a new task.
  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.priority,
    this.isCompleted = false,
  });

  Task copyWith({
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    TaskCategory? category,
    TaskPriority? priority,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
