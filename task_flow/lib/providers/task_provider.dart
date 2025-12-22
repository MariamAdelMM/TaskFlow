import 'package:flutter_riverpod/legacy.dart';
import 'package:task_flow/models/tasks.dart';

// 1. Create a StateNotifier that manages a list of tasks
class TaskNotifier extends StateNotifier<List<Task>> {
  //means it manages a list of Task objects
  TaskNotifier() : super([]); //initializes the state as an empty list.
  //StateNotifier is a controller for your data. Whenever state changes, widgets that watch this provider automatically rebuild.

  // 2. Add a new task
  void addTask(Task task) {
    state = [...state, task];
    //creates a new list containing all existing tasks plus the new one. //creating a new list ensures the UI updates.
  }

  // 3. Update a task at a given index
  void updateTask(String id, Task updatedTask) {
    final newState = [...state]; //creates a copy of the current list.
    // ❌ If you modify state directly, UI may not rebuild
    // ✅ Creating a new list guarantees Riverpod detects the change
    final index = newState.indexWhere(
      (task) => task.id == id,
    ); //Loops over every task in newState Compares task.id with the provided id Returns the index of the first match
    if (index == -1) return; // to prevent crash
    newState[index] =
        updatedTask; //i take the task i want to update from the new array and make it equal to the updated task
    state = newState; //updates Riverpod state, which triggers UI rebuilds.
  }

  // 4. Delete a task at a given index
  void deleteTask(int index) {
    final newState = [...state];
    newState.removeAt(index);
    state = newState;
  }

  // 5. Toggle completion status
  void toggleComplete(int index) {
    final newState = [...state];
    //creates a new Task object based on the old one, but with isCompleted toggled.
    newState[index] = newState[index].copyWith(
      isCompleted: !newState[index]
          .isCompleted, //! the opposite of what i currently have
    );
    state = newState;
  }

  // 6. Get task details by index
  Task getTask(int index) {
    return state[index];
  }
}

// 7. Create a Riverpod provider
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  //taskProvider ===> provider you will use in your widgets.
  return TaskNotifier();
});

//NOTES
////////////////////////////

// ref.read(provider)
// Purpose: Read the current value of a provider once.
// Does not rebuild the widget if the provider changes.
// Usually used when you want to call a method on a notifier or get a value once, e.g., in a button’s onPressed.
//onPressed: () {
//   ref.read(taskProvider.notifier).addTask(newTask);
// }
//Here, we don’t need to rebuild the widget—just want to tell the notifier to add a task.
/////////////////////////
//ref.watch(provider)
//Purpose: Subscribe to a provider and rebuild the widget automatically whenever the provider changes.
// Use this inside build when you want your UI to update with provider state.
/////////////////////////
//ref.listen(provider, (previous, next) => ...)
// Purpose: React to changes in a provider without rebuilding the widget.
// Useful for side effects, like showing a snackbar, navigation, logging, or saving data.
//ref.listen(taskProvider, (previous, next) {
//   if (next.length > previous.length) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('New task added!')),
//     );
//   }
// });
