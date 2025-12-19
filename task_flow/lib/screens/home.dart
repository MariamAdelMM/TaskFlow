import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/data/data.dart';
import 'package:task_flow/screens/add_task.dart';
import 'package:task_flow/widgets/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String taskTitle = '';
  String taskDescription = '';
  String taskDate = '';
  String taskTime = '';
  String taskCategory = '';
  String taskPriority = '';

  Future<void> _loadTask() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      taskTitle = prefs.getString('title') ?? '';
      taskDescription = prefs.getString('description') ?? '';
      taskDate = prefs.getString('date') != null
          ? DateTime.parse(
              prefs.getString('date')!,
            ).toLocal().toString().split(' ')[0]
          : '';
      taskTime = prefs.getString('time') != null
          ? prefs.getString('time')!
          : '';
      taskCategory = prefs.getString('category') ?? '';
      taskPriority = prefs.getString('priority') ?? '';
    });
  }

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  void _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'User';
    });
  }

  void _onAddPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTasksScreen()),
    );
  }

  final List<Map<String, dynamic>> items = [
    {'icon': Icons.task_alt, 'label': 'Completed', "number": 2},
    {'icon': Icons.timer, 'label': 'Overdue', "number": 1222},
    {'icon': Icons.analytics, 'label': 'Upcoming', "number": 12},
  ];

  @override
  void initState() {
    super.initState();
    _loadName(); //// load name when screen initializes
    _loadTask(); // load the task when home screen opens
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 0,
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 216, 184),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 24,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Welcome, ${capitalize(name)}!',

                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  CategoriesItems(tasks: dummyTasks),
                  const SizedBox(height: 16),
                  if (taskTitle.isNotEmpty)
                    Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title: $taskTitle',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Description: $taskDescription',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Date: $taskDate',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Time: $taskTime',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Category: $taskCategory',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Priority: $taskPriority',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: const Icon(Icons.add, size: 32),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
