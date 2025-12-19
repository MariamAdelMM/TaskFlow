import 'package:task_flow/models/tasks.dart';

final List<Task> dummyTasks = [
  Task(
    title: 'Design UI',
    description: 'Create dashboard UI',
    date: DateTime.now().subtract(const Duration(days: 1)),
    status: TaskStatus.completed,
    priority: TaskPriority.high,
    category: TaskCategory.home,
  ),
  Task(
    title: 'Fix bugs',
    description: 'Resolve login issues',
    date: DateTime.now().subtract(const Duration(days: 2)),
    status: TaskStatus.overdue,
    priority: TaskPriority.medium,
    category: TaskCategory.work,
  ),
  Task(
    title: 'Prepare report',
    description: 'Monthly analytics',
    date: DateTime.now().add(const Duration(days: 3)),
    status: TaskStatus.upcoming,
    priority: TaskPriority.low,
    category: TaskCategory.study,
  ),
  Task(
    title: 'API integration',
    description: 'Connect backend',
    date: DateTime.now(),
    status: TaskStatus.completed,
    priority: TaskPriority.high,
    category: TaskCategory.home,
  ),
];
