import 'package:flutter/material.dart';
import 'package:task_flow/screens/home.dart';
import 'package:task_flow/screens/profile.dart';
import 'package:task_flow/screens/tasks.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<Tabs> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    TasksScreen(),
    ProfileScreen(),
  ];
  void _handleTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _handleTap(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
