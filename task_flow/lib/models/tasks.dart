import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

enum TaskCategory { work, home, shopping, study, personal, health }

extension TaskCategoryX on TaskCategory {
  //An extension lets you add extra functionality to an existing type without modifying it
  IconData get icon {
    //get makes icon a getter. It allows you to read a value without using parentheses ().
    //The getter checks which TaskCategory it is.then it returns the correct icon for that category.
    switch (this) {
      //this = the current enum value
      case TaskCategory.work:
        return Icons.work_outline;
      case TaskCategory.home:
        return Icons.home_outlined;
      case TaskCategory.shopping:
        return Icons.shopping_cart_outlined;
      case TaskCategory.study:
        return Icons.school_outlined;
      case TaskCategory.personal:
        return Icons.person_outline;
      case TaskCategory.health:
        return Icons.favorite_outline;
    }
  }

  String get label {
    return name[0].toUpperCase() + name.substring(1);
  }
}

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
