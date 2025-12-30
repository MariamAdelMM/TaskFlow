import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/providers/task_provider.dart';

// Helper to get month name
String _getMonthName(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}

class DailyTasksScreen extends ConsumerWidget {
  const DailyTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final count = tasks.where((task) => !task.isCompleted).length;
    final String dateStr =
        "${DateTime.now().day} ${_getMonthName(DateTime.now().month)}";
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateStr.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white54,
                    letterSpacing: 1.2,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5389d5).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    count == 0 ? 'ALL DONE' : 'IN PROGRESS',
                    style: TextStyle(
                      color: count == 0
                          ? Color.fromARGB(255, 83, 135, 208)
                          : Color.fromARGB(255, 232, 31, 0),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 24, color: Colors.white),
                children: [
                  const TextSpan(text: 'You have '),
                  TextSpan(
                    text: '$count tasks',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              count == 0 ? 'Enjoy your free day!' : 'to complete.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
