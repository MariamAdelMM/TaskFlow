enum TaskStatus { completed, overdue, upcoming }

enum TaskPriority { low, medium, high }

enum TaskCategory { work, home, study }

class Task {
  final String title;
  final String description;
  final DateTime date;
  final TaskStatus status;
  final TaskPriority priority;
  final TaskCategory category;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.priority,
    required this.category,
  });
}
