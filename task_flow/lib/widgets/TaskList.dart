import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    if (tasks.isEmpty) {
      return Text(
        'No tasks yet',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: tasks.length > 3 ? 3 : tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Card(
              color: const Color.fromRGBO(31, 22, 43, 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (_) {
                        ref.read(taskProvider.notifier).toggleComplete(index);
                      },
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Date: ${task.date.day}/${task.date.month}/${task.date.year} at ${task.time.format(context)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Category: ${task.category.name[0].toUpperCase()}${task.category.name.substring(1)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        ref.read(taskProvider.notifier).deleteTask(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
