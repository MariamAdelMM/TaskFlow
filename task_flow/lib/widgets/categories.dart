import 'package:flutter/material.dart';

class CategoriesItems extends StatelessWidget {
  CategoriesItems({super.key});

  final List<Map<String, dynamic>> items = [
    {'icon': Icons.task_alt, 'label': 'Completed', "number": 2},
    {'icon': Icons.timer, 'label': 'Overdue', "number": 1222},
    {'icon': Icons.analytics, 'label': 'Upcoming', "number": 12},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(items.length, (index) {
        final item = items[index];
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
              Icon(item['icon'], color: Colors.white, size: 32),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
