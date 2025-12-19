import 'package:flutter/material.dart';

//int getCompletedCount(List<Task> tasks) =>
// tasks.where((t) => t.status == TaskStatus.completed).length;
// int total = getCompletedCount(tasks);
// Text(total.toString());
// void → function RETURNS NOTHING
//use void when a function is meant to DO something, not GIVE something back
//Print something, Update UI, Call an API, Show a dialog/snackbar, Change a value
//this is void  onPressed: () {
// print('Button clicked');
// },

class CategoriesItems extends StatelessWidget {
  const CategoriesItems({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'color': const Color(0xFF4ADB7E),
        'icon': Icons.task_alt,
        'label': 'Completed',
        'number': 0,
      },
      {
        'color': const Color(0xFFf97171),
        'icon': Icons.timer,
        'label': 'Overdue',
        'number': 0,
      },
      {
        'color': const Color(0xFF5389d5),
        'icon': Icons.analytics,
        'label': 'Upcoming',
        'number': 0,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((item) {
        return Container(
          width: 100,
          height: 130,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(31, 22, 43, 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(item['icon'], color: item['color'], size: 26),
              ),
              const SizedBox(height: 12),
              Text(
                item['label'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item['number'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
