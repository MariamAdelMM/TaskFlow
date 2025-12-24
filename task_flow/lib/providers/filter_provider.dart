import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:task_flow/models/tasks.dart';
import 'package:task_flow/providers/task_provider.dart';

final taskSearchProvider = StateProvider<String>((ref) => '');
//This creates a variable in Riverpod that holds a String.
//The initial value is an empty string ''.
//Purpose: As you type in your TextField, you will update this value.

final priorityFilterProvider = StateProvider<TaskPriority?>((ref) => null);
// This holds the current priority filter.
// It is nullable (TaskPriority?) because null represents "Show All".
// Purpose: When a user clicks a "High" or "Low" chip, you will store that choice here.

final filteredTasksProvider = Provider<List<Task>>((ref) {
  //a provider that will return a List<Task> to your UI.
  final allTasks = ref.watch(taskProvider);
  final searchTerm = ref.watch(taskSearchProvider).toLowerCase();
  final selectedPriority = ref.watch(priorityFilterProvider);
  //Note: Because we use ref.watch, this whole function re-runs automatically every time any of those three things change.
  return allTasks.where((task) {
    //If the logic inside returns true, the task stays; if false, it's removed from the view.
    final matchesSearch = task.title.toLowerCase().contains(searchTerm);
    //==>>>which task of my all tasks has the search term???
    final matchesPriority =
        selectedPriority == null || task.priority == selectedPriority;
    //selectedPriority == null ==>If no filter is chosen, this is always true (show everything).
    //This ensures that when no filter is selected, all tasks are allowed to show up.
    return matchesSearch && matchesPriority;
  }).toList();
});
//StateProvider and StateNotifierProvider (which uses a StateNotifier)
// are two different tools used for different levels of complexity. 
//You aren't "wrong"—StateNotifier is a very common way to manage state,
// but StateProvider is a simpler alternative for basic data.
//it is A simple "box" that holds a single value (like a String, a Boolean, or an Integer).
// How it works: You can change its value directly from the UI using ref.read(provider.notifier).state = newValue.
//Best For: Filters, search bars, toggles, or simple counters.


//StateNotifier is a class used for complex states where you
// want to keep the "business logic" separate from the UI.