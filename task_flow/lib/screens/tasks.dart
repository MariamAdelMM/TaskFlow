import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/models/tasks.dart';
import 'package:task_flow/providers/filter_provider.dart';
import 'package:task_flow/screens/add_task.dart';
import 'package:task_flow/screens/details.dart';
import 'package:task_flow/screens/edit.dart';
import '../providers/task_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onAddPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddTasksScreen()),
      );
    }

    // final tasks = ref.watch(taskProvider); no longer reading from taskprovider directly
    // We watch the original task list to see if the database is actually empty
    final allOriginalTasks = ref.watch(taskProvider);

    // We watch the filtered tasks for the current display
    final tasks = ref.watch(filteredTasksProvider);
    final currentPriority = ref.watch(priorityFilterProvider);

    final Widget emptyDatabaseContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
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
    );

    final Widget content = allOriginalTasks.isEmpty
        ? emptyDatabaseContent
        : Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search by title...',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    prefixIconColor: Colors.white,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(taskSearchProvider.notifier).state = value;
                    //If you used watch inside an onChanged function, you would be telling
                    //the widget to rebuild itself while it is in the middle of a specific user action
                    //watch: Tells the widget to "keep an eye on this provider." If the provider
                    //changes, the entire build method runs again.
                  },
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 4),
                      child: FilterChip(
                        showCheckmark: false,
                        label: const Text('All'),
                        labelStyle: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                        selected: currentPriority == null,
                        onSelected: (_) =>
                            ref.read(priorityFilterProvider.notifier).state =
                                null,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                      ),
                    ),
                    ...TaskPriority.values.map((priority) {
                      final isSelected = currentPriority == priority;
                      //This compares the priority of the button we are currently
                      // building with the currentPriority stored in Riverpod.
                      //If they match, isSelected becomes true, telling the button to look "active"
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilterChip(
                          showCheckmark: false,
                          avatar: Icon(
                            priority.icon,
                            size: 16,
                            color: priority.color,
                          ),
                          label: Text(
                            priority.name[0].toUpperCase() +
                                priority.name.substring(1),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            //This runs whenever the user taps a chip.
                            ref.read(priorityFilterProvider.notifier).state =
                                selected ? priority : null;
                            //if the chip was just turned "on," it sets
                            // Riverpod's state to that priority. If the
                            // user tapped an already-selected chip to turn
                            //it "off," it sets the state to null (which shows all tasks).
                          },
                          selectedColor: priority.color.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: priority.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: tasks.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 60,
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No matching tasks found!',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
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
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) {
                                ref
                                    .read(taskProvider.notifier)
                                    .deleteTask(task.id);
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsScreen(task: task),
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
                                                  .toggleComplete(task.id);
                                            },
                                            shape: const CircleBorder(),
                                          ),
                                        ),

                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      decoration:
                                                          task.isCompleted
                                                          ? TextDecoration
                                                                .lineThrough
                                                          : TextDecoration.none,
                                                      decorationColor:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Text(
                                                'Due: ${task.date.day}/${task.date.month}/${task.date.year} at: ${task.time.format(context)}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Category: ${task.category.label}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 6),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: task.category.color
                                                .withOpacity(0.5),
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
                                          icon: const Icon(Icons.more_vert),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    EditTasksScreen(task: task),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Task List'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(6), child: content),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: const Color.fromARGB(255, 180, 143, 220),
        child: const Icon(Icons.add, size: 32),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
