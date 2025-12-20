import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/models/tasks.dart';
import '../providers/task_provider.dart';

class AddTasksScreen extends ConsumerStatefulWidget {
  const AddTasksScreen({super.key});

  @override
  ConsumerState<AddTasksScreen> createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends ConsumerState<AddTasksScreen> {
  //after converting to consumerStatefull state ref is now available in _AddTasksScreenState, which lets you access your provider.
  //By default, ref.watch(taskProvider) or ref.read(taskProvider) gives you the current state (the List<Task>).
  // But if you want to call methods that modify the state (like adding a task), you need the .notifier
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TaskPriority selected = TaskPriority.low;
  TaskCategory selectedCategory = TaskCategory.work;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatTime(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;
    final String period = hour >= 12 ? "PM" : "AM";
    final int hour12 = hour == 0
        ? 12
        : hour > 12
        ? hour - 12
        : hour;

    final String minutes = minute.toString().padLeft(2, '0');

    return "$hour12:$minutes $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('Add New Task'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Title',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Task Title is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Description",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Description is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Due date',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),

                              child: InkWell(
                                //prssable
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    //The ? means nullable. this variable can be either a DateTime OR null.
                                    context: context,
                                    initialDate: _selectedDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                  );
                                  if (pickedDate != null) {
                                    setState(() => _selectedDate = pickedDate);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                    ),
                                    const SizedBox(width: 4),

                                    Text(
                                      _formatDate(_selectedDate),
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    _selectedTime = pickedTime;
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatTime(_selectedTime),
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Column(
                    children: [
                      Row(
                        children: TaskCategory.values.take(3).map((category) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: ChoiceChip(
                                label: Center(
                                  child: Text(
                                    category.name[0].toUpperCase() +
                                        category.name.substring(1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                ),
                                selected: selectedCategory == category,
                                onSelected: (_) {
                                  setState(() => selectedCategory = category);
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: TaskCategory.values.skip(3).take(3).map((
                          category,
                        ) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: ChoiceChip(
                                label: Center(
                                  child: Text(
                                    category.name[0].toUpperCase() +
                                        category.name.substring(1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                ),
                                selected: selectedCategory == category,
                                onSelected: (_) {
                                  setState(() => selectedCategory = category);
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'Priority',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: TaskPriority.values.map((priority) {
                      //creates 3 chips
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Center(
                              child: Text(
                                priority.name[0].toUpperCase() +
                                    priority.name.substring(1),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                            selected:
                                selected ==
                                priority, //decides which chip is active
                            onSelected: (i) {
                              setState(() => selected = priority);
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        //A bottom navigation bar to display at the bottom of the scaffold.
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final newTask = Task(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    date: _selectedDate,
                    time: _selectedTime,
                    category: selectedCategory,
                    priority: selected,
                    isCompleted: false,
                  );
                  ref.read(taskProvider.notifier).addTask(newTask);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Task Added successfully',
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
                  Navigator.pop(context, '/tabs');
                }
              },
              child: Text(
                "Add Task",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
