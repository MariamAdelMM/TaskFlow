import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/providers/filter_provider.dart';

class DailyTasksScreen extends ConsumerWidget {
  const DailyTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider for today's tasks
    final dailyTasks = ref.watch(filteredTasksProvider);
    // Define the content variable based on whether the list is empty
    Widget content;
    if (dailyTasks.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5389d5).withOpacity(0.15),
              ),
              child: const Center(
                child: Icon(
                  Icons.checklist_outlined,
                  size: 40,
                  color: Color(0xFF5389d5),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'No Tasks Yet',
              style: TextStyle(
                color: Color(0xFF5389d5),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      content = _buildHeader(context, dailyTasks.length);
    }
    return Padding(padding: const EdgeInsets.all(8), child: content);
  }

  Widget _buildHeader(BuildContext context, int count) {
    final String dateStr =
        "${DateTime.now().day} ${_getMonthName(DateTime.now().month)}";

    return Container(
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
                  style: const TextStyle(
                    color: Color(0xFF5389d5),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 28, color: Colors.white),
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
            count == 0 ? 'Enjoy your free day!' : 'to complete today.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

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
}
