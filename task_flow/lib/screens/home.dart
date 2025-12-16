import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/data/data.dart';
import 'package:task_flow/widgets/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';

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

  final List<Map<String, dynamic>> items = [
    {'icon': Icons.task_alt, 'label': 'Completed', "number": 2},
    {'icon': Icons.timer, 'label': 'Overdue', "number": 1222},
    {'icon': Icons.analytics, 'label': 'Upcoming', "number": 12},
  ];

  @override
  void initState() {
    super.initState();
    _loadName(); // load name when screen initializes
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
              CategoriesItems(tasks: dummyTasks),
            ],
          ),
        ),
      ),
    );
  }
}
