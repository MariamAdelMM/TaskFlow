import 'package:flutter_riverpod/legacy.dart';
import 'package:task_flow/models/tasks.dart';

// 1. Create a StateNotifier that manages a list of tasks
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  // 2. Add a new task
  void addTask(Task task) {
    state = [...state, task]; // add new task to the list
  }

  // 3. Update a task at a given index
  void updateTask(int index, Task updatedTask) {
    final newState = [...state];
    newState[index] = updatedTask;
    state = newState;
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
    newState[index] = newState[index].copyWith(
      isCompleted: !newState[index].isCompleted,
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
  return TaskNotifier();
});
