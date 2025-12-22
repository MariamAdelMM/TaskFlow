import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/models/tasks.dart';
import 'package:task_flow/screens/add_task.dart';
import 'package:task_flow/screens/edit.dart';
import '../providers/task_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _onAddPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddTasksScreen()),
      );
    }

    final tasks = ref.watch(taskProvider);

    final Widget content = tasks.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 90,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(height: 12),
                Text(
                  'No Tasks Yet',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,

                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Dismissible(
                    key: ValueKey(task.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      ref.read(taskProvider.notifier).deleteTask(task.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Task Deleted Successfully',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSecondaryContainer,
                            ),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          margin: const EdgeInsets.all(16),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
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
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: task.isCompleted,
                                activeColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                onChanged: (_) {
                                  ref
                                      .read(taskProvider.notifier)
                                      .toggleComplete(index);
                                },
                                shape: const CircleBorder(),
                              ),
                            ),

                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        task.priority.icon,
                                        color: task.priority.color,
                                        size: 16,
                                      ),

                                      const SizedBox(width: 4),
                                      Text(
                                        task.title,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          decoration: task.isCompleted
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          decorationColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    'Due: ${task.date.day}/${task.date.month}/${task.date.year} at ${task.time.format(context)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Category: ${task.category.label}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 6),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: task.category.color.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  task.category.icon,
                                  color: task.category.color,
                                  size: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditTasksScreen(task: task),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('Task List'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(6), child: content),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: const Color.fromARGB(255, 214, 192, 239),
        child: const Icon(Icons.add, size: 32),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
