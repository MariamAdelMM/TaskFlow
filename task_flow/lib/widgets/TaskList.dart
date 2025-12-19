import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  String taskTitle = '';
  String taskDescription = '';
  String taskDate = '';
  String taskTime = '';
  String taskCategory = '';
  String taskPriority = '';
  bool isCompleted = false;

  Future<void> _loadTask() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      taskTitle = prefs.getString('title') ?? '';
      taskDescription = prefs.getString('description') ?? '';
      taskDate = prefs.getString('date') ?? '';
      taskTime = prefs.getString('time') ?? '';
      taskCategory = prefs.getString('category') ?? '';
      taskPriority = prefs.getString('priority') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();

    _loadTask(); // load the task when home screen opens
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: const Color.fromRGBO(31, 22, 43, 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: isCompleted,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (value) {
                  setState(() {
                    isCompleted = value ?? false;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Date: $taskDate at $taskTime',
                    style: TextStyle(color: Colors.white),
                  ),

                  Text(
                    'Category: $taskCategory',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
